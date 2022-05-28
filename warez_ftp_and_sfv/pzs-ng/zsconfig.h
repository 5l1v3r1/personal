/* zsconfig.h - ZipScript-C config file
 *
 * This file only contains overrides of the defaults. If you need to edit/change
 * other options, please copy the option from README.ZSCONFIG and place it in
 * here.
 * The complete list of options availible is found in README.ZSCONFIG.
 *
 * Please do not change settings you do not understand!
 *
 * The hash char ``#'' does not signify comments! DO NOT REMOVE!
 */


/* DO NOT USE WILDCARDS HERE! */
#define sitepath_dir                 "/site/"
#define group_dirs                   "/site/groups/ /site/private/"
#define zip_dirs                     "/site/archive/software/ /site/incoming/software /site/incoming/games/ /site/archive/games/"
#define sfv_dirs                     "/site/archive/abooks/ /site/archive/console/ /site/archive/dvdr/ /site/archive/ebooks/ /site/archive/games/ /site/archive/mbluray/ /site/archive/mdvdr/ /site/archive/mp3/ /site/archive/mvids/ /site/archive/pda/ /site/archive/scenenotices/ /site/archive/software/ /site/archive/tutorial/ /site/archive/tv720p/ /site/archive/x264720p/ /site/archive/x264sd/ /site/archive/xxxsd/ /site/incoming/abooks/ /site/incoming/console/ /site/incoming/dvdr/ /site/incoming/ebooks/ /site/incoming/games/ /site/incoming/mbluray/ /site/incoming/mdvdr/ /site/incoming/mp3/ /site/incoming/mvids/ /site/incoming/pda/ /site/incoming/scenenotices/ /site/incoming/software/ /site/incoming/tutorial/ /site/incoming/tv720p/ /site/incoming/x264720p/ /site/incoming/x264sd/ /site/incoming/xxxsd/"
#define nocheck_dirs                 "/site/private/ /site/speedtest/"
#define noforce_sfv_first_dirs       "/site/incoming/requests/"
#define audio_nocheck_dirs           "/site/archive/abooks/ /site/archive/console/ /site/archive/dvdr/ /site/archive/ebooks/ /site/archive/games/ /site/archive/mbluray/ /site/archive/mdvdr/ /site/archive/mvids/ /site/archive/pda/ /site/archive/scenenotices/ /site/archive/software/ /site/archive/tutorial/ /site/archive/tv720p/ /site/archive/x264720p/ /site/archive/x264sd/ /site/archive/xxxsd/ /site/incoming/abooks/ /site/incoming/console/ /site/incoming/dvdr/ /site/incoming/ebooks/ /site/incoming/games/ /site/incoming/mbluray/ /site/incoming/mdvdr/ /site/incoming/mvids/ /site/incoming/pda/ /site/incoming/scenenotices/ /site/incoming/software/ /site/incoming/tutorial/ /site/incoming/tv720p/ /site/incoming/x264720p/ /site/incoming/x264sd/ /site/incoming/xxxsd/"
#define allowed_types_exemption_dirs "/site/incoming/mvids/ /site/archive/mvids/"
#define check_for_missing_nfo_dirs   "/site/archive/abooks/ /site/archive/console/ /site/archive/dvdr/ /site/archive/ebooks/ /site/archive/games/ /site/archive/mbluray/ /site/archive/mdvdr/ /site/archive/mp3/ /site/archive/mvids/ /site/archive/pda/ /site/archive/scenenotices/ /site/archive/software/ /site/archive/tutorial/ /site/archive/tv720p/ /site/archive/x264720p/ /site/archive/x264sd/ /site/archive/xxxsd/ /site/incoming/abooks/ /site/incoming/console/ /site/incoming/dvdr/ /site/incoming/ebooks/ /site/incoming/games/ /site/incoming/mbluray/ /site/incoming/mdvdr/ /site/incoming/mp3/ /site/incoming/mvids/ /site/incoming/pda/ /site/incoming/scenenotices/ /site/incoming/software/ /site/incoming/tutorial/ /site/incoming/tv720p/ /site/incoming/x264720p/ /site/incoming/x264sd/ /site/incoming/xxxsd/"
#define cleanupdirs                  "/site/test/ /site/incoming/games/ /site/incoming/apps/ /site/incoming/musicvideos/"
#define cleanupdirs_dated            "/site/incoming/software/%m%d/ /site/incoming/mp3/%m%d/"

#define check_for_missing_sample_dirs "/site/incoming/x264720p/ /site/archive/x264720p/ /site/incoming/x264sd/ /site/archive/x264sd/ /site/incoming/xxxsd/ /site/archive/xxxsd/ /site/incoming/tv720p/ /site/archive/tv720p/"
#define create_missing_sample_link   TRUE

#define short_sitename               "OK"

#define debug_mode                   FALSE
#define debug_altlog                 TRUE

#define status_bar_type              BAR_DIR
#define incompleteislink             TRUE

#define ignored_types                ",diz,debug,message,imdb,html,url,m3u,metadata"

#define deny_double_sfv              TRUE
#define force_sfv_first              FALSE

#define audio_genre_path             "/site/sorted/mp3/sorted.by.genre/"
#define audio_artist_path            "/site/sorted/mp3/sorted.by.artist/"
#define audio_year_path              "/site/sorted/mp3/sorted.by.year/"
#define audio_group_path             "/site/sorted/mp3/sorted.by.group/"
#define audio_language_path          "/site/sorted/mp3/sorted.by.language/"
#define allowed_constant_bitrates    "160,192"
#define allowed_years                "2020,2021"
#define banned_genres                ""
#define allowed_genres               ""
#define audio_genre_sort             TRUE
#define audio_year_sort              TRUE
#define audio_artist_sort            TRUE
#define audio_group_sort             TRUE
#define audio_language_sort          TRUE
#define audio_cbr_check              TRUE
#define audio_cbr_warn               TRUE
#define audio_year_check             TRUE
#define audio_year_warn              TRUE
#define audio_banned_genre_check     TRUE
#define audio_allowed_genre_check    FALSE
#define audio_genre_warn             TRUE

#define enable_nfo_script               FALSE
#define nfo_script                      "/bin/psxc-imdb.sh"
#define enable_complete_script          TRUE
#define complete_script                 "/bin/nfo_copy.sh"
#define enable_audio_script             TRUE
#define audio_script                    "/bin/ng-chown"
#define audio_script_cookies            "0 0 0 1 0 1 - \"%w\" \"%?\""
#define allow_gid_change_in_ng_chown    TRUE
#define allow_dir_chown_in_ng_chown     TRUE