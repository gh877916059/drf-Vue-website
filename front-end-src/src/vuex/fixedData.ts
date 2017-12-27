export interface questionState {
    name: string;
    code: number;
}

const questionStateList: questionState[] = [
    {code: 1, name: '待解决'},
    {code: 2, name: '已解决'},
    {code: 3, name: '悬赏'}
];

export default {
    questionStateList
};
