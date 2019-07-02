Return-Path: <martin@linuxlounge.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxlounge.net;
	s=mail; t=1562057182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	to:to:cc:cc:content-type:content-type:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references:openpgp:openpgp:autocrypt:autocrypt;
	bh=HcrU3xHf2es9K1eWmG8nbhDoxCTyXkGXB9fNsN37JPM=;
	b=cpOxtmSaP4trU3ozqBS66YZqBZWhUwjWDFuCuUs9XDb55dKzLjizVEO9O2JeTgOhFskerw
	IinNen6G4pMYKhk0XtE6GbHHBvu2IBjIMPTPZLmOUfLO8qc7svfe4VJhoL6uiyxZc4Aa3u
	EOuyYNmZ3JRSgRJrPNuAVkqg4TXOJUo=
References: <41ac3aa3-cbf7-1b7b-d847-1fb308334931@linuxlounge.net>
	<E0170D52-C181-4F0F-B5F8-F1801C2A8F5A@cumulusnetworks.com>
	<21ab085f-0f7f-88bc-b661-af74dd9eeea2@linuxlounge.net>
	<cc232ed3-9e02-ebb4-4901-9d617013abb8@cumulusnetworks.com>
	<3fcf8b05-e1ad-ac97-10bf-bd2b6354424c@linuxlounge.net>
	<908e9e90-70cc-7bbe-f83f-0810c9ef3925@cumulusnetworks.com>
	<5e43ba82-de32-e419-efc3-5dfca8291973@linuxlounge.net>
	<6dc6e89b-8b40-7dac-ec69-f4223d5dc147@cumulusnetworks.com>
From: Martin Weinelt <martin@linuxlounge.net>
Message-ID: <c66cd547-6cbe-40bf-e42c-d307956644fa@linuxlounge.net>
Date: Tue, 2 Jul 2019 10:46:22 +0200
In-Reply-To: <6dc6e89b-8b40-7dac-ec69-f4223d5dc147@cumulusnetworks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] Use-after-free in br_multicast_rcv
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, bridge@lists.linux-foundation.org, Roopa Prabhu <roopa@cumulusnetworks.com>
Cc: netdev@vger.kernel.org

Hi Nik,

On 7/2/19 12:37 AM, Nikolay Aleksandrov wrote:
> On 7/2/19 1:17 AM, Martin Weinelt wrote:
>> Hi again,
>>
>> On 7/1/19 7:37 PM, Nikolay Aleksandrov wrote:
>>> I see, thanks for clarifying this. So on the KASAN could you please try the attached patch ?
>>> Also could you please run the br_multicast_rcv+xxx addresses through
>>> linux/scripts/faddr2line for your kernel/bridge:
>>> usage: faddr2line [--list] <object file> <func+offset> <func+offset>...
>>>
>>> Thanks,
>>>  Nik
>>>
>>
>> back with a new report. This is 5.2.0-rc7 + your patch.
>>
>> Best,
>>   Martin
>>
> 
> Thanks! Aaargh.. I made a stupid mistake hurrying to send the patch, apologies.
> Here's the fixed version, please give it a go. This report is because
> of my change, not because of the previous bug that should've been fixed.
> 

I applied your latest patch against 5.2.0-rc7 and it seems to have fixed the issue as,
after 6 hours of uptime, the KASAN report isn't coming up anymore.

Also there are currently no kmemleak results coming up on 5.2.0-rc7, so I'll be
looking at the v4.19.x series next.

Thank you!

Best
  Martin
