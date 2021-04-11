#include <opencv2/opencv.hpp>
#include <opencv2/stitching.hpp>
#include <opencv2/imgproc.hpp>
#include <android/log.h>
using namespace cv;
using namespace std;

// Avoiding name mangling
extern "C" {
    // Attributes to prevent 'unused' function from being removed and to make it visible
    __attribute__((visibility("default"))) __attribute__((used))
    const char* version() {
        return CV_VERSION;
    }


__attribute__((visibility("default"))) __attribute__((used))

struct tokens: ctype<char>
{
    tokens(): std::ctype<char>(get_table()) {}

    static std::ctype_base::mask const* get_table()
    {
        typedef std::ctype<char> cctype;
        static const cctype::mask *const_rc= cctype::classic_table();

        static cctype::mask rc[cctype::table_size];
        std::memcpy(rc, const_rc, cctype::table_size * sizeof(cctype::mask));

        rc[','] =  ctype_base::space;
        rc[' '] =  ctype_base::space;
        return &rc[0];
    }
};
    vector<string> getpathlist(string path_string){
         string sub_string = path_string.substr(1,path_string.length()-2);
         stringstream ss(sub_string);
        ss.imbue( locale( locale(), new tokens()));
         istream_iterator<std::string> begin(ss);
         istream_iterator<std::string> end;
         vector<std::string> pathlist(begin, end);
        return pathlist;
    }


    Mat stich_all_image_to_mat(vector<string> img_list){
        vector<Mat> imgVec;
        for(auto k=img_list.begin();k!=img_list.end();++k)
        {
            String  path = *k;
            Mat input = imread(path);
            Mat newimage;
            // Convert to a 3 channel Mat to use with Stitcher module
            cvtColor(input, newimage, COLOR_BGR2RGB,3);
            // Reduce the resolution for fast computation
            float scale = 1000.0f / input.rows;
            resize(newimage, newimage, Size(scale * input.rows, scale * input.cols));
            imgVec.push_back(newimage);
        }

        Mat result = Mat();
          Stitcher::Mode mode = Stitcher::PANORAMA;
        Ptr<Stitcher> stitcher = Stitcher::create(mode);
            Stitcher::Status status = stitcher->stitch(imgVec, result);
            if (status != Stitcher::OK)
            {
                 hconcat(imgVec,result);
                 __android_log_print(ANDROID_LOG_VERBOSE,"C++Message","NOW WE ARE IN C++ AND UNABLE TO STITCH IMAGES");
                __android_log_print(ANDROID_LOG_VERBOSE,"C++Message", to_string(status).c_str());

             }else{
                __android_log_print(ANDROID_LOG_VERBOSE,"C++Message","NOW WE ARE IN C++ AND STITCHING IS DONE SUCCESSFULLY");
             }

        cvtColor(result, result, COLOR_RGB2BGR);
        resize(result, result, Size(result.rows, result.cols));
        return result;
    }

    void process_image(char* inputImagePath, char* outputImagePath) {
        __android_log_print(ANDROID_LOG_VERBOSE,"C++Message","WORKING ON STITCHER");
        string input_path_string =  inputImagePath;
        __android_log_print(ANDROID_LOG_VERBOSE,"C++Message","%s", input_path_string.c_str());
        vector<string> image_vector_list=getpathlist(input_path_string);
        Mat result =stich_all_image_to_mat(image_vector_list);
        imwrite(outputImagePath,result);
    }

}