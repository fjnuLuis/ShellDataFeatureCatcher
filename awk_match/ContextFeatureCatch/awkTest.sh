#!/bin/bash
# Name: awkTest.sh
# Description: 
# Author: Lin
# Version: 0.0.1
# Datetime: 2017-01-07 16:28:59
# Usage: awkTest.sh

#head /tmp/danmu.txt | awk '
if [ ! -n "$1" ] ;then
	echo "Usage:./awkTest.sh /path/to/FILENAME EMOJI_TYPE{1..4}"
	exit 1
fi
if [ ! -f "$1" ] ;then
	echo "File is not exist."
	exit 2
fi

if [ ! -n "$2" ] ;then
	echo "Usage:./awkTest.sh /path/to/FILENAME EMOJI_TYPE{1..4}"
	exit 1
fi
if [ $2 -eq 1 ] || [ $2 -eq 2 ] || [ $2 -eq 3 ] || [ $2 -eq 4 ] || [ $2 -eq 5 ];then
	echo "Waiting for analysis."
else
	echo "The Type must in {1..4}"
	exit 2
fi
cat  $1  | awk '
############ FUNCTION ##############

function cutStr()
{	
	n=split($0,chars,"");
}

### 打印哈希表值 ###
function printStr()
{
	for(i=1;i<=n;i++)
		printf("%s\t",chars[i]);
	printf("\n");

}

### 模式匹配主函数 ###
function matchStr()
{
	for(i=0;i<=n;i++){
		count_Digit(chars[i]);
		count_ZHCN(chars[i]);
		count_English(chars[i]);
		count_punct(chars[i]);
		count_superChar(chars[i]);
	}
}

### 数字模式计数 ### 
function count_Digit(value)
{
	if(value>="0" && value <= "9")
		m_digitC++;

}

### 中文模式计数 ###
function count_ZHCN(value)
{
	if(value > "\177" && value != "。" && value !="，" && value !="：" && value != "”" && value != "’" && value !="—" && value != "　" && value !="！" && value !="（" && value !="）" && value !="？"  && value !="；"  && value !="‘"  && value !="“"  && value !="《"  && value !="》"  && value !="、" && value != "·" && value != "￥" && value != "…"){
		m_ZHCNC++;
#		printf("%s_%s\t",value,complex[value]);
		if(complex[value] == 1){
#			printf("%s_%s\t",value,complex[value]);
			m_complexC++;
			}
	}
}

### 标点模式计数 ###
function count_punct(value)
{
	if(value > "\177" && (value == "。" || value =="，" || value =="：" || value == "”" || value == "’" || value =="—" || value == "　" || value =="！" || value =="（" || value =="）" || value =="？"  || value =="；"  || value =="‘"  || value =="“"  || value =="《"  || value =="》"  || value =="、" ))
		m_punctC++;
	else{
		if(value >="\040" && value <= "\042" || value >="\050" && value <= "\051" || value == "\047" ||  value >="\072" && value <= "\073" || value == "," || value == "." || value == "?" )
			m_punctC++;
	
	}

}

### 英文模式计数 ###
function count_English(value)
{
	if(value >= "a" && value <= "z" || value >= "A" && value <= "Z")
		m_EnglishC++;

}

### 特殊字符模式计数 ###
function count_superChar(value)
{
	if(value == "·" || value == "￥" || value == "…" ||  value >="\043" && value <= "\046" || value >="\052" && value <= "\053"|| value =="\055" || value == "\057" || value >="\074" && value <= "\076" || value == "\100" || value >="\133" && value <= "\137" || value >="\173" && value <= "\177" || value == "\140" )	
		m_superC++;
}

### 弹幕标点替换 ###
function replacePunct(value,ind)
{
#	if(value >"\177" && (value == "。" || value =="，" || value =="：" || value == "”" || value == "’" || value =="—" || value == "　" || value =="！" || value =="（" || value =="）" || value =="？"  || value =="；"  || value =="‘"  || value =="“"  || value =="《"  || value =="》"  || value =="、" )){
	if(value >"\177"){
		tmp[ind]="+";		
	}
	else{
	#	if(value >="\040" && value <= "\042" || value >="\050" && value <= "\051" || value == "\047" ||  value >="\072" && value <= "\073" || value == "," ){
		if(value >="\040" && value <= "\042" || value == "$"  || value >="\053" && value <= "\054" || value == "\047" ||  value >="\073" && value <= "\076" && value != "=" || value >= "\133"  && value <= "\136" || value =="`" || value >= "\173" && value <= "\175" ){
			tmp[ind]="+";

		}
        }

	#if(value > "\177" && value != "。" && value !="，" && value !="：" && value != "”" && value != "’" && value !="—" && value != "　" && value !="！" && value !="（" && value !="）" && value !="？"  && value !="；"  && value !="‘"  && value !="“"  && value !="《"  && value !="》"  && value !="、" && value != "·" && value != "￥" && value != "…")
	#	tmp[ind]=" ";


}

### URL首段判断 
function matchURLOne(value){
	alone=0;
	if(index(value,"http")== 1){
		alone=1;

	}else if(index(value,"http")==0){
		if(value~/[^[:alnum:]-]/)
			alone=0;
		else
			alone=1;

	}else{
		alone=2;
	}
}



### 弹幕出去非英文 ###
function replaceNotAlpha(value,ind)
{
	if(value > "\177" || value<"A" || value >"Z" && value < "a" || value > "z"  )
		pin_tmp[ind]=" ";		

}

### 匹配表情个数 ###
function countEmoji(){
	choice='''$2''';
	emo_count=0;
	if(choice == 1){
		# 熊猫
		#[:文字]

		ide_emo_x=index(danmu,"[:");
		str_emo=danmu;
		while(ide_emo_x>0){
		#	printf("(%d_%d)",emo_count,ide_emo_x);
		#	printf("(%s) ",str_emo);
			ide_emo_y=index(str_emo,"]");
			if(ide_emo_y>ide_emo_x){
				str_emo=substr(str_emo,ide_emo_y+1);
		#		printf("(%s) ",str_emo);
				emo_count++;
				ide_emo_x=index(str_emo,"[:");
			}else if(ide_emo_y>0){
				str_emo=substr(str_emo,ide_emo_y+1);
				ide_emo_x=index(str_emo,"[:");
			}else{
				break;
			}
		}
		printf("%d\t",emo_count);

	}else if(choice == 2){
		# 斗鱼
		#[emot:dy3位数字]
	

		ide_emo_x=index(danmu,"[emot:dy");
		str_emo=danmu;
		while(ide_emo_x>0){
		#	printf("(%d_%d)",emo_count,ide_emo_x);
		#	printf("(%s) ",str_emo);
			ide_emo_y=index(str_emo,"]");
			if(ide_emo_y>ide_emo_x){
				str_emo=substr(str_emo,ide_emo_y+1);
		#		printf("(%s) ",str_emo);
				emo_count++;
				ide_emo_x=index(str_emo,"[emot:dy");
			}else if(ide_emo_y>0){
				str_emo=substr(str_emo,ide_emo_y+1);
				ide_emo_x=index(str_emo,"[emot:dy");
			}else{
				break;
			}
		}
		printf("%d\t",emo_count);


	}else if(choice == 3){
		# 战旗
		# [文字]

		ide_emo_x=index(danmu,"[");
		str_emo=danmu;
		while(ide_emo_x>0){
		#	printf("(%d_%d)",emo_count,ide_emo_x);
		#	printf("(%s) ",str_emo);
			ide_emo_y=index(str_emo,"]");
			if(ide_emo_y>ide_emo_x){
				str_emo=substr(str_emo,ide_emo_y+1);
	#			printf("(%s) ",str_emo);
				emo_count++;
				ide_emo_x=index(str_emo,"[");
			}else if(ide_emo_y>0){
				str_emo=substr(str_emo,ide_emo_y+1);
	#			printf("(%s) ",str_emo);
				ide_emo_x=index(str_emo,"[");
			}else{
				break;
			}
		}
		printf("%d\t",emo_count);



	}else if(choice == 4){
		# 待定手机直播
		#

		ide_emo_x=index(danmu,"[:");
		str_emo=danmu;
		while(ide_emo_x>0){
		#	printf("(%d_%d)",emo_count,ide_emo_x);
		#	printf("(%s) ",str_emo);
			ide_emo_y=index(str_emo,"]");
			if(ide_emo_y>ide_emo_x){
				str_emo=substr(str_emo,ide_emo_y+1);
		#		printf("(%s) ",str_emo);
				emo_count++;
				ide_emo_x=index(str_emo,"[:");
			}else if(ide_emo_y>0){
				str_emo=substr(str_emo,ide_emo_y+1);
				ide_emo_x=index(str_emo,"[:");
			}else{
				break;
			}
		}
		printf("%d\t",emo_count);


	}else{

		# 微博
		# [文字]

		ide_emo_x=index(danmu,"[");
		str_emo=danmu;
		while(ide_emo_x>0){
		#	printf("(%d_%d)",emo_count,ide_emo_x);
		#	printf("(%s) ",str_emo);
			ide_emo_y=index(str_emo,"]");
			if(ide_emo_y>ide_emo_x){
				str_emo=substr(str_emo,ide_emo_y+1);
		#		printf("(%s) ",str_emo);
				emo_count++;
				ide_emo_x=index(str_emo,"[");
			}else if(ide_emo_y>0){
				str_emo=substr(str_emo,ide_emo_y+1);
				ide_emo_x=index(str_emo,"[");
			}else{
				break;
			}
		}
		printf("%d\t",emo_count);


	}



}

### 匹配是否只含表情 ###
function matchEmoji(){
	choice='''$2''';
	if(choice == 1){
		# 熊猫
		# [:文字]

		if(danmu~/^(\[:[^]]+\])+$/)
			printf("1\t");
		else
			printf("0\t");

	}else if(choice == 2){
		# 斗鱼
		# [emot:dy3位数字]


		if(danmu~/^(\[emot:dy[^]]+\])+$/)
			printf("1\t");
		else
			printf("0\t");



	}else if(choice == 3){
		# 战旗
		# [文字]

		if(danmu~/^(\[[^]]+\])+$/)
			printf("1\t");
		else
			printf("0\t");

	}else if(choice == 4){
		# 待定手机直播
		#

	}else{

		# 微博
		# [文字]

		if(danmu~/^(\[[^]]+\])+$/)
			printf("1\t");
		else
			printf("0\t");


	}



}


### 查询英文数据库 ###
function ifExist(value)
{
	sql="mysql -ulin -plin -D words -h localhost -e \"select COUNT(id) from words where word='\''"value"'\''\" | grep 1 &>/dev/null && exit 0  || exit 1";
	res=system(sql);
	return res;

}

### 将单词、繁体字导入哈希表 ###
function initWord()
{
	while(getline w< "./word/words.txt")
		words[w]=1;

	
#	while(getline c< "./font/complex.txt")
#	{
		
#		complex[c]=1;
#		printf("%s_%s ",complex[c],c);
#	}



	getline c< "./font/complex";
	com_num=split(c,com_tmp,"");
	for(com_i=1;com_i<=com_num;com_i++)
		complex[com_tmp[com_i]]=1;
#	printf("%s\n",com_tmp[100]);



#	printf("\n");
}

### 特殊弹幕标记（URL，全中文） ###
function matchInfo(){

	### 匹配是否包含URL ###
	flag=0;
	danmu=$0;
	split(danmu,tmp,"");
	result="";
	for(j=1;j<=n;j++){
		replacePunct(tmp[j],j);
		result=result""tmp[j];
	}
	#printf("[%s]\t",result);
	num=split(result,tmp,"+");
	for(k=1;k<=num;k++){
	#	printf("%s_%d\t",tmp[k],length(tmp[k]));
		if(tmp[k]~/[[:alnum:]\-]+([\.][[:alnum:]\-]+)+([[:alnum:]\-\.,@?^=%&:\/~\+#]*[[:alnum:]\-\@?^=%&\/~\+#])?/ && length(tmp[k]) >= 4){
			url_num=split(tmp[k],buf,".")
			urlLength=split(tmp[k],charUrl,"");
			urlEngC=0;
			for(m=1;m<=urlLength;m++)
				if(charUrl[m] >= "a" && charUrl[m] <= "z" || charUrl[m] >= "A" && charUrl[m] <= "Z")
					urlEngC++;
			if(urlEngC >= 3){
				matchURLOne(buf[1]);	
				for(l=1;l<=url_num;l++){
					if(length(buf[l])<2)
						break;
				}
			#	printf("%d,%d\t",l,url_num);
				if(l>url_num && alone>=1)
					flag=1;
			}
		}
	}
	printf("%d\t",flag);
	### 只含URL ###
	#printf("[%d]",num);
	if(flag==1 && num == 1 && alone ==1) printf("1\t");
	else	printf("0\t");
	
	### 匹配是否包含拼音 ###
	pin_res="";
	pin_flag=0;
	split(danmu,pin_tmp,"");
	for(pin_i=1;pin_i<=n;pin_i++){
		replaceNotAlpha(pin_tmp[pin_i],pin_i);
		pin_res=pin_res""pin_tmp[pin_i];
	}
#	printf( "%s\t",pin_res);
	pin_num=split(pin_res,pin," ");
	for(pin_i=1;pin_i<=pin_num;pin_i++){
		if(pin[pin_i] != "" && words[pin[pin_i]] != 1){
		#	printf("Exist=%s\t",words[pin[pin_i]]);
			if(pin[pin_i]~/[^a-zA-Z]?(an|ai|ao|ei|en|er|bang|ba[ino]?|beng|be[in]?|bing|bia[no]?|bi[en]?|bu|cang|ca[ino]?|ceng|ce[in]?|chang|cha[ino]?|cheng|che[n]?|chi|chong|chou|chuang|chua[in]|chu[ino]?|ci|cong|cou|cuan|cu[ino]?|dang|da[ino]?|deng|de[in]?|dia[no]?|ding|di[ae]?|dong|dou|duan|du[ino]?|fang|fan|fa|feng|fe[in]{1}|fo[u]?|fu|gang|ga[ino]?|geng|ge[in]?|gong|gou|guang|gua[in]?|gu[ino]?|hang|ha[ino]?|heng|he[in]?|hong|hou|huang|hua[in]?|hu[ino]?|jiang|jia[no]?|jiong|ji[nu]?|juan|ju[en]?|kang|ka[ino]?|keng|ke[n]?|kong|kou|kuang|kua[in]?|ku[ino]?|lang|la[ino]?|leng|le[i]?|liang|lia[no]?|ling|li[enu]?|long|lou|luan|lu[no]?|lv[e]?|mang|ma[ino]?|meng|me[in]?|mia[no]?|ming|mi[nu]?|mo[u]?|mu|nang|na[ino]?|neng|ne[in]?|niang|nia[no]?|ning|ni[enu]?|nong|nou|nuan|nu[on]?|nv[e]?|pang|pa[ino]?|pa|peng|pe[in]?|ping|pia[no]?|pi[en]?|po[u]?|pu|qiang|qia[no]?|qiong|qing|qi[aenu]?|quan|qu[en]?|rang|ra[no]{1}|reng|re[n]?|rong|rou|ri|ruan|ru[ino]?|sang|sa[ino]?|seng|se[n]?|shang|sha[ino]?|sheng|she[in]?|shi|shou|shuang|shua[in]?|shu[ino]?|si|song|sou|suan|su[ino]?|tang|ta[ino]?|teng|te|ting|ti[e]?|tia[no]?|tong|tou|tuan|tu[ino]?|wang|wa[ni]?|weng|we[in]{1}|w[ou]{1}|xiang|xia[no]?|xiong|xing|xi[enu]?|xuan|xu[en]|yang|ya[no]?|ye|ying|yi[n]?|yong|you|yo|yuan|yu[en]?|zang|za[ino]?|zeng|ze[in]?|zhang|zha[ino]?|zheng|zhe[in]?|zhi|zhong|zhou|zhuang|zhua[in]?|zhu[ino]?|zi|zong|zou|zuan|zu[ino]?)/){
#			if(pin[pin_i]~/[^a-zA-Z]?(a[io]+|ou?|e[inr]+|ang?|ng|[bmp](a[io]?|[aei]ng?|ei|ie?|ia[no]|o|u)|pou|me|m[io]u|[fw](a|[ae]ng?|ei|o|u)|fou|wai|[dt](a[io]?|an|e|[aeio]ng|ie?|ia[no]|ou|u[ino]?|uan)|dei|diu|[nl](a[io]?|ei?|[eio]ng|i[eu]?|i?ang?|iao|in|ou|u[eo]?|ve?|uan)|nen|lia|lun|[ghk](a[io]?|[ae]ng?|e|ong|ou|u[aino]?|uai|uang?)|[gh]ei|[jqx](i(ao?|ang?|e|ng?|ong|u)?|u[en]?|uan)|([csz]h?|r)([ae]ng?|ao|e|i|ou|u[ino]?|uan)|[csz](ai?|ong)|[csz]h(ai?|uai|uang)|zei|[sz]hua|([cz]h|r)ong|y(ao?|[ai]ng?|e|i|ong|ou|u[en]?|uan))/){
				pin_flag=1;
				}
		}
	}
	printf("%d\t",pin_flag);


		countEmoji();

	### 匹配是否包含表情 ###

		matchEmoji();





}

### 特征值打印 ###
function printFeature(){
	printf("%s\t",length);
	printf("%s\t",m_digitC);
	printf("%s\t",m_ZHCNC);
	printf("%s\t",m_complexC);
	printf("%s\t",m_EnglishC);
	printf("%s\t",m_punctC);
	printf("%s\t",m_superC);
	matchInfo();	
	printf("\"%s\"",$0);
	printf("\n");

}

### 变量初始化 ###
function init()
{
	m_digitC=0;
	m_ZHCNC=0;
	m_EnglishC=0;
	m_punctC=0;
	m_superC=0;
	m_complexC=0;
}
########### BEGIN  ################
BEGIN{

	printf("弹幕长度 数字个数 中文个数 繁体个数 英文个数 标点个数 特殊个数 包含URL 只含URL 包含拼音 表情个数 只含表情 弹幕信息\n");
	initWord();


}

########### MAIN ##################
{
	init();
	cutStr();
	matchStr();	
#	print;
	printFeature();
}

########### END ###################
END{


}
' > feature.txt

echo "Analysis OK."
