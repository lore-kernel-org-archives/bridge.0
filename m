Return-Path: <roopa@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=l0OQSVEmfCX/6WvBLZKl0bFYaFrdaT5X5d2qM7ANddA=;
	b=NdlbwNSMUOoMV2q0bibchvSfkUqAomjYA2HKMSjsWt0OHnjcRAZNeChGkUb2OSPTxP
	Klguxn6H1ipfLk0CwSW84KEydP5y3B6OPz1NURqE4IhCZl1NBEsEk6MQ4Hr9C0SJ9m7Z
	ZtFpqoz3+fIwCPJIIftmrkekaTtFKnck0BuzI=
MIME-Version: 1.0
In-Reply-To: <8737eb73-3437-5529-6f4d-7aa52c770357@gmail.com>
References: <1503980568-35240-1-git-send-email-roopa@cumulusnetworks.com>
	<8737eb73-3437-5529-6f4d-7aa52c770357@gmail.com>
From: Roopa Prabhu <roopa@cumulusnetworks.com>
Date: Tue, 29 Aug 2017 10:36:50 -0700
Message-ID: <CAJieiUh6D5iUBBq1owL-=Sja9bEYYLOT6P7NTgKZYOMDwyLr_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] [PATCH net-next v2] bridge: fdb add and delete
	tracepoints
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, "davem@davemloft.net" <davem@davemloft.net>

On Tue, Aug 29, 2017 at 9:46 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 08/28/2017 09:22 PM, Roopa Prabhu wrote:
>> From: Roopa Prabhu <roopa@cumulusnetworks.com>
>>
>> A few useful tracepoints to trace bridge forwarding
>> database updates.
>>
>> Signed-off-by: Roopa Prabhu <roopa@cumulusnetworks.com>
>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
>
> Small nit below, but probably not a candidate for a v3
>
>> ---
>
>> +
>> +     TP_printk("dev %s addr %02x:%02x:%02x:%02x:%02x:%02x vid %u nlh_flags %04x ndm_flags = %02x",
>
> Small nit, any particular reason why ndm_flags got a special treatment
> with an equal character and not the other?
>


good eyes, thats a typo. I did scan them once and removed the '=' and
missed a spot.
i will send v3.
