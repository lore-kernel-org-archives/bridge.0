Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:from:to:cc:references:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=Q0vmPs4YL5Qmtfli/VH/0lsB9Ep4mMtKja2fne3rfaU=;
	b=MG3FrL/FgWs5TvynBgMPAd22w9AtseB35xsSWEJnQKPPk8fKjmtNqWsvvhY5BT7Yq4
	vkLN/LFSucg6WH9FgCiW1BiG3hnVsXmKd7skuOU+XFKHD9NcdcR8z8KhjQVr46ikOeI0
	YT71D12uDYKff6IXppzYwU2aMGfs3FVhm/diA=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
References: <20190702204705.GC28471@lunn.ch>
	<55f24bfb-4239-dda8-24f8-26b6b2fa9f9e@cumulusnetworks.com>
Message-ID: <4a015cbf-41bc-8ba0-94b5-ec2702e51c33@cumulusnetworks.com>
Date: Wed, 3 Jul 2019 00:21:05 +0300
MIME-Version: 1.0
In-Reply-To: <55f24bfb-4239-dda8-24f8-26b6b2fa9f9e@cumulusnetworks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Validation of forward_delay seems wrong...
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev <netdev@vger.kernel.org>, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org

On 03/07/2019 00:19, Nikolay Aleksandrov wrote:
> On 02/07/2019 23:47, Andrew Lunn wrote:
>> Hi Nikolay
>>
>> The man page says that the bridge forward_delay is in units of
>> seconds, and should be between 2 and 30.
>>
>> I've tested on a couple of different kernel versions, and this appears
>> to be not working correctly:
>>
>> ip link set br0 type bridge forward_delay 2
>> RTNETLINK answers: Numerical result out of range
>>
>> ip link set br0 type bridge forward_delay 199
>> RTNETLINK answers: Numerical result out of range
>>
>> ip link set br0 type bridge forward_delay 200
>> # 
>>
>> ip link set br0 type bridge forward_delay 3000
>> #
>>
>> ip link set br0 type bridge forward_delay 3001
>> RTNETLINK answers: Numerical result out of range
>>
>> I've not checked what delay is actually being used here, but clearly
>> something is mixed up.
>>
>> grep HZ .config 
>> CONFIG_HZ_PERIODIC=y
>> # CONFIG_NO_HZ_IDLE is not set
>> # CONFIG_NO_HZ_FULL is not set
>> # CONFIG_NO_HZ is not set
>> CONFIG_HZ_FIXED=0
>> CONFIG_HZ_100=y
>> # CONFIG_HZ_200 is not set
>> # CONFIG_HZ_250 is not set
>> # CONFIG_HZ_300 is not set
>> # CONFIG_HZ_500 is not set
>> # CONFIG_HZ_1000 is not set
>> CONFIG_HZ=100
>>
>> Thanks
>> 	Andrew
>>
> 
> Hi Andrew,
> The man page is wrong, these have been in USER_HZ scaled clock_t format from the beginning.
> TBH a lot of the time/delay bridge config options are messed up like that.
> We've been discussing adding special _ms versions in iproute2 to make them
> more user-friendly and understandable. Will cook a patch for the man page.
> 
> Cheers,
>  Nik
> 
> 

Err, I meant it is seconds just scaled, if it wasn't clear.


