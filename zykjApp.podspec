#
#  Be sure to run `pod spec lint BLAPIManagers.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "zykjApp"
  s.version      = "118"
  s.summary      = "zykjApp."

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description  = <<-DESC
                    this is zykjApp
                   DESC

  s.homepage     = "https://github.com/xiaozo/zykjapp"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Licensing your code is important. See http://choosealicense.com for more info.
  #  CocoaPods will detect a license file if there is a named LICENSE*
  #  Popular ones are 'MIT', 'BSD' and 'Apache License, Version 2.0'.
  #

  # s.license      = "MIT (example)"
  s.license      = { :type => "MIT", :file => "FILE_LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the authors of the library, with email addresses. Email addresses
  #  of the authors are extracted from the SCM log. E.g. $ git log. CocoaPods also
  #  accepts just a name if you'd rather not provide an email address.
  #
  #  Specify a social_media_url where others can refer to, for example a twitter
  #  profile URL.
  #

  s.author             = { "CasaTaloyum" => "casatwy@msn.com" }
  # Or just: s.author    = "CasaTaloyum"
  # s.authors            = { "CasaTaloyum" => "casatwy@msn.com" }
  # s.social_media_url   = "http://twitter.com/CasaTaloyum"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If this Pod runs only on iOS or OS X, then specify the platform and
  #  the deployment target. You can optionally include the target after the platform.
  #

  # s.platform     = :ios
  s.platform     = :ios, "7.0"

  #  When using multiple platforms
  # s.ios.deployment_target = "5.0"
  # s.osx.deployment_target = "10.7"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #

  s.source       = { :git => "https://github.com/xiaozo/zykjapp.git", :tag => s.version.to_s }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any swift, h, m, mm, c & cpp files.
  #  For header files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

  #//这是需要添加mrc标识的文件，为相对路径
  non_arc_files = 'zykjApp/zykjApp/NoArc/*.{h,m,swift}'
  utils_files = "zykjApp/zykjApp/Utils/**/*.{h,m,swift}"
  api_files = "zykjApp/zykjApp/API/**/*.{h,m,swift}"
  model_files = "zykjApp/zykjApp/Model/**/*.{h,m,swift}"
  help_files = "zykjApp/zykjApp/Helper/**/*.{h,m,swift}"
  views_files = "zykjApp/zykjApp/Views/**/*.{h,m,swift}"
  uiFramework_files = "zykjApp/zykjApp/UIFramework/**/*.{h,m,swift}"
  ext_files = "zykjApp/zykjApp/Ext/**/*.{h,m,swift}"

  #//一下就是子设置，为需要添加mrc标识的文件进行设置
  s.subspec 'no-arc' do |sp|

  sp.source_files = non_arc_files

  sp.requires_arc = false

  end

  s.source_files  = "zykjApp/zykjApp/**/*.{h,m,swift}"

  #在工程中首先排除一下
  s.exclude_files = non_arc_files,utils_files,api_files,model_files,uiFramework_files,views_files,help_files,ext_files

  # #二级目录 NoArc
  # s.subspec 'NoArc' do |ss|
  #   ss.source_files = non_arc_files
  # #二级目录
  #   end

       #二级目录 Utils
   s.subspec 'Utils' do |ss|
    ss.source_files = utils_files
  #二级目录
    end

   #二级目录 UIFramework
   s.subspec 'UIFramework' do |ss|
    ss.source_files = uiFramework_files
  #二级目录
    end

   #二级目录 model
   s.subspec 'Model' do |ss|
    ss.source_files = model_files
  #二级目录
    end

       #二级目录 Helper
   s.subspec 'Helper' do |ss|
    ss.source_files = help_files
  #二级目录
    end

   #二级目录 views
   s.subspec 'Views' do |ss|
    myAudio_files = "zykjApp/zykjApp/Views/MyAudio/**/*.{h,m,swift}"
    multiPictureView2_files = "zykjApp/zykjApp/Views/MultiPictureView2/**/*.{h,m,swift}"
    bRPickerView_files = "zykjApp/zykjApp/Views/BRPickerView/**/*.{h,m,swift}"
    wkwebView_files = "zykjApp/zykjApp/Views/WkwebView/**/*.{h,m,swift}"
    iCViewPager_files = "zykjApp/zykjApp/Views/ICViewPager/**/*.{h,m,swift}"
    iCNavViewPager_files = "zykjApp/zykjApp/Views/ICNavViewPager/**/*.{h,m,swift}"
    lEEAlert_files = "zykjApp/zykjApp/Views/LEEAlert/**/*.{h,m,swift}"
    multiPictureView_files = "zykjApp/zykjApp/Views/MultiPictureView/**/*.{h,m,swift}"
    placeHolderTextView_files = "zykjApp/zykjApp/Views/PlaceHolderTextView/**/*.{h,m,swift}"
    
    ss.source_files = views_files
    ss.exclude_files = bRPickerView_files,multiPictureView2_files,wkwebView_files,iCViewPager_files,iCNavViewPager_files,lEEAlert_files,multiPictureView_files,placeHolderTextView_files,myAudio_files

    ss.subspec 'MyAudio' do |sss|
      sss.source_files = myAudio_files
      end

      ss.subspec 'MultiPictureView2' do |sss|
        sss.source_files = multiPictureView2_files
        end

        ss.subspec 'BRPickerView' do |sss|
        sss.source_files = bRPickerView_files
        end

    ss.subspec 'WkwebView' do |sss|
    sss.source_files = wkwebView_files
    end

    ss.subspec 'ICViewPager' do |sss|
      sss.source_files = iCViewPager_files
      end

      ss.subspec 'ICNavViewPager' do |sss|
        sss.source_files = iCNavViewPager_files
        end

        ss.subspec 'LEEAlert' do |sss|
          sss.source_files = lEEAlert_files
          end

          ss.subspec 'MultiPictureView' do |sss|
            sss.source_files = multiPictureView_files
            end

            ss.subspec 'PlaceHolderTextView' do |sss|
              sss.source_files = placeHolderTextView_files
              end

  #二级目录
    end


  # #二级目录 API
  #  s.subspec 'API' do |ss|
  #   api_core_files = "zykjApp/zykjApp/API/core/**/*.{h,m,swift}"
  #   api_IosApiRequestUtil_files = "zykjApp/zykjApp/API/IosApiRequestUtil/**/*.{h,m,swift}"
      
  #   ss.subspec 'core' do |sss|
  #   sss.source_files = api_core_files
  #   end

  #   ss.subspec 'IosApiRequestUtil' do |sss|
  #   sss.source_files = api_IosApiRequestUtil_files
  #   end
  # #二级目录
  #   end

    #二级目录 Ext
   s.subspec 'Ext' do |ss|
    myLayout_files = "zykjApp/zykjApp/Ext/MyLayout/**/*.{h,m,swift}"
    mJRefresh_files = "zykjApp/zykjApp/Ext/MJRefresh/**/*.{h,m,swift}"
    masonry_files = "zykjApp/zykjApp/Ext/Masonry/**/*.{h,m,swift}"
    aFNetworking_files = "zykjApp/zykjApp/Ext/AFNetworking/**/*.{h,m,swift}"
    commonLibrary_files = "zykjApp/zykjApp/Ext/CommonLibrary/**/*.{h,m,swift}"
    fMDB_files = "zykjApp/zykjApp/Ext/FMDB/**/*.{h,m,swift}"
    mSSBrowse_files = "zykjApp/zykjApp/Ext/MSSBrowse/**/*.{h,m,swift}"
    sDCycleScrollView_files = "zykjApp/zykjApp/Ext/SDCycleScrollView/**/*.{h,m,swift}"
    sDWebImage_files = "zykjApp/zykjApp/Ext/SDWebImage/**/*.{h,m,swift}"
    xHImageViewer_files = "zykjApp/zykjApp/Ext/XHImageViewer/**/*.{h,m,swift}"
    yyKit_files = "zykjApp/zykjApp/Ext/YYKit/**/*.{h,m,swift}"
    zLPickerLib_files = "zykjApp/zykjApp/Ext/ZLPickerLib/**/*.{h,m,swift}"

    ss.source_files = ext_files
    ss.exclude_files = myLayout_files,mJRefresh_files,masonry_files,aFNetworking_files,commonLibrary_files,fMDB_files,mSSBrowse_files,sDCycleScrollView_files,sDWebImage_files,xHImageViewer_files,yyKit_files,zLPickerLib_files
    
    ss.subspec 'MyLayout' do |sss|
      sss.source_files = myLayout_files
      end

    ss.subspec 'MJRefresh' do |sss|
      sss.source_files = mJRefresh_files
      end

    ss.subspec 'Masonry' do |sss|
    sss.source_files = masonry_files
    end

    ss.subspec 'AFNetworking' do |sss|
    sss.source_files = aFNetworking_files
    end

      ss.subspec 'CommonLibrary' do |sss|
      sss.source_files = commonLibrary_files
      end

      ss.subspec 'FMDB' do |sss|
      sss.source_files = fMDB_files
      end

      ss.subspec 'MSSBrowse' do |sss|
        sss.source_files = mSSBrowse_files
        end

        ss.subspec 'SDCycleScrollView' do |sss|
          sss.source_files = sDCycleScrollView_files
          end

      ss.subspec 'SDWebImage' do |sss|
      sss.source_files = sDWebImage_files
       end

       ss.subspec 'XHImageViewer' do |sss|
        sss.source_files = xHImageViewer_files
         end

         ss.subspec 'YYKit' do |sss|
          sss.source_files = yyKit_files
           end

           ss.subspec 'ZLPickerLib' do |sss|
            sss.source_files = zLPickerLib_files
             end

  #二级目录
    end



  # s.exclude_files = "Classes/Exclude"

  # s.public_header_files = "Classes/**/*.h"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"
  
  # s.resource = 'Resoure/**/*.xcassets'
  s.resources = ['Resoure/**/*.xcassets', 'Resoure/**/*.bundle']
  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  s.requires_arc = true

  #s.dependency "Noarc"

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "BLNetworking"
  # s.dependency "BLAPIManagers"
  # s.dependency "BLMediator"

  s.dependency "ReactiveObjC"

  s.frameworks = 'Accelerate', 'CoreTelephony', 'SystemConfiguration'
  #//不带tbd后缀及lib前缀
  s.libraries = 'c++', 'sqlite3' , 'z'

  # 本库提供的 .a 静态库
  s.vendored_libraries  = 'zykjApp/zykjApp/Views/MyAudio/Vendor/AMR/lib/*.a'

  s.prefix_header_contents = <<-PRE
                  #ifdef __OBJC__
                  #import "AllHeader.h"
                  #else
                  #endif
                 PRE

# s.requires_arc =  'zykjApp/zykjApp/API'
# s.requires_arc = true
 #s.requires_arc = ['zykjApp/zykjApp/API', 'zykjApp/zykjApp/Ext', 'zykjApp/zykjApp/Helper', 'zykjApp/zykjApp/Model', 'zykjApp/zykjApp/VC', 'zykjApp/zykjApp/Utils', 'zykjApp/zykjApp/Views']


end
