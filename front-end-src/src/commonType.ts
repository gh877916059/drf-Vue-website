import Constants from "./constants";
import {Vue} from "vue-property-decorator";

export interface Dict {
    [index: string]: any;
}

export interface KeyValueDict {
    [index: string]: string;
}

export interface CaseCategory {
    id: number;
    name: string;
    sub_cat?: CaseCategory[];
    parent_category?: number;
}

export class CaseData {
    cases_front_image: string = '';
    name: string = '暂无标题';
    cases_brief: string = '暂无简介';
    category_name: string = '未知类别';
    add_time: string = '未知日期';
    cases_desc: string = '案例详情';
    user_avatar: string = Constants.REQUEST_HOST + '/static/image/fail.jpg';
    click_num: number = 0;
    reply_num: number = 0;
    fav_num: number = 0;
    id: number = 0;
    rating_num: number = 0;
    sum_rating_score: number = 0;
    constructor(resDict: Dict) {
        resDict['category_name'] = resDict['category']['name'];
        delete resDict['category'];
        delete resDict['cases_desc'];
        resDict['cases_front_image'] = Constants.REQUEST_HOST + resDict['cases_front_image'];
        for (let key in resDict) {
            if(this.hasOwnProperty(key)) {
                this[key] = resDict[key];
            }
        }
    }
}

export class QuestionData {
    user_avatar: string = Constants.REQUEST_HOST + '/static/image/fail.jpg';
    question_brief: string = '暂无简介';
    name: string = '暂无标题';
    id: number = 0;
    add_time: string = '未知日期';
    constructor(resDict: Dict) {
        for (let key in resDict) {
            if(this.hasOwnProperty(key)) {
                this[key] = resDict[key];
            }
        }
    }
}

export class BannerData {
    hyperlink: string = '#';
    image: string = Constants.REQUEST_HOST + '/static/image/fail.jpg';
    title: string = '暂无标题';
    constructor(resDict: Dict) {
        for (let key in resDict) {
            if(this.hasOwnProperty(key)) {
                this[key] = resDict[key];
            }
        }
    }
}

export default {
};
