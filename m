Return-Path: <noltari@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-type:content-transfer-encoding;
	bh=stAK70iWnZhl6ACCVGYQWTmyVxgDID9B1BJTGhr+I5Q=;
	b=WAYOW4wBwP5i+hP9ub6+spxfN+pUnyIlL/8TCW74yds7PQ6voRir0ZB4bs3jAMOj2W
	kto5Fr/1Nyifd8IKOwMzSk+Wn+VeCrOSLct7vwiBYSmgT55eU6/nwrCQFywrRhadbifn
	dFmUZ9y1ZrmWyJn0bQMzmC8K8jJsyu7egZYexTX0BkxqSSkjSNfKxZHOg2alwCKNqSZw
	CFzWd14tYUTBpJIvQHbOIj0VHeV5Ml6ZiEVittbHB0zubMm9ee7YampsWvN0bQ9KfGS+
	bZ4uLrnibe4qMh5Gm9bOGLRe4HOcDMFfSSasFzW3NHeMDsj9uP4DVzYNBRHz+71zS8gm
	nSaA==
References: <56A2993B.4070307@gmail.com> <20160122131046.6f141681@xeon-e3>
From: =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>
Message-ID: <56A2AF73.2090204@gmail.com>
Date: Fri, 22 Jan 2016 23:38:43 +0100
MIME-Version: 1.0
In-Reply-To: <20160122131046.6f141681@xeon-e3>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] hw csum failure introduced in linux-4.2
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: bridge@lists.linux-foundation.org, davem@davemloft.net

Yes, I could reproduce it on OpenWrt using linux-4.4 on a Raspberry Pi 2.
https://gist.github.com/Noltari/5b1cfdecce5ed4bc08fd

No, I didn't open any issue on the kernel bugzilla.
If you want me to report it somewhere else I don't have any problem with it.

Regards,
Álvaro.

El 22/01/2016 a las 22:10, Stephen Hemminger escribió:
> On Fri, 22 Jan 2016 22:03:55 +0100
> Álvaro Fernández Rojas <noltari@gmail.com> wrote:
>
>>   From linux-4.2 there's a "hw csum failure" for bridges using hardware
>> checksums when IPv6 multicast traffic is received.
>>
>> Here are some reports:
>> https://lkml.org/lkml/2015/12/1/699
>> https://bugzilla.redhat.com/show_bug.cgi?id=1266601
>> https://discourse.osmc.tv/t/hw-csum-failure/9990
>> https://github.com/raspberrypi/linux/issues/1259
>>
>> I think it may have been introduced in commit
>> 9afd85c9e4552b276e2f4cfefd622bdeeffbbf26 (net: Export IGMP/MLD message
>> validation code) but I haven't done any tests to confirm it.
>> Any help on this issue would be really appreciated.
>>
>> Regards,
>> Álvaro.
> What hardware? You missed the kernel bugzilla? If it was reported
> there I would have forwarded it to netdev@vger.kernel.org.
>
> Can you reproduce it with 4.4?

