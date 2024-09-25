Received: from smtpbg156.qq.com (smtpbg156.qq.com [15.184.82.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1304A157490
	for <bridge@lists.linux.dev>; Wed, 25 Sep 2024 07:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.82.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727250367; cv=none; b=rFUCrDh//wqF32Nczz0oPUAn6yDDLZprRaiyN58ng58fE/TjWjtw8n0cVkWAklbTdcidX2BeQXc3hP3EBSp4/eQ7wbNLFRUt5FofyAM6jQrwhaLh1OCnOcdwrbciye++88HtAHy/WFK8kP9XUqlc3VRlCzuCkvNNyJ2t5KjhWmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727250367; c=relaxed/simple;
	bh=ZUProyu00ja80ci1A0RXcLmyyBjWY9msWbU/KAg4HIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fK3doco2XIZxer3UmnExxtLu7x3Y/jvuN3DnU3HhXR/RTHbKKrYXxGxek72GMGD+C1aBt6Q8mOCs5PjH5ncOyKc0IcwAqQ4bSa05gkZeUKz6qF2hbNA+p5vw9jm0bbMPr9CW2xZwmmOap3q9AFAZ0G1kUJg5o25LDlNdbyMNrlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=PJHX/Lu/; arc=none smtp.client-ip=15.184.82.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="PJHX/Lu/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1727250325;
	bh=sMEaKZQcq/TtGsA51jEZ9Lr0IGSJ55RWX+ZF3Zx81xc=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=PJHX/Lu/UeFiNKnqQL4WgV8B8F7KtfAcYc+1xmbdZdEiUhWyis82B5sqWxyyD+g/4
	 rVozeqYXLYTBkDId47KB+X/IeFaFqmO6EpjR4htZ1n9k3qGzgJQ/DiVMTfz88f+/5V
	 chXYg4NJlH4dfHUYdo3HvEIGk27XQCMwiiWCM/tY=
X-QQ-mid: bizesmtp78t1727250322tqckfpzb
X-QQ-Originating-IP: fxt20V0vtp7XFP4+BckSlREbZu54Gq5LMBLejmguxFg=
Received: from [10.20.255.96] ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 25 Sep 2024 15:45:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3157228644688347360
Message-ID: <81A3C9D37E72666E+13e8b5ef-8499-45e6-9442-060ef88152d8@uniontech.com>
Date: Wed, 25 Sep 2024 15:45:20 +0800
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net/bridge: Optimizing read-write locks in ebtables.c
To: Stephen Hemminger <stephen@networkplumber.org>,
 Eric Dumazet <edumazet@google.com>
Cc: pablo@netfilter.org, kadlec@netfilter.org, roopa@nvidia.com,
 razor@blackwall.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, gouhao@uniontech.com
References: <14BD7E92B23BF276+20240924090906.157995-1-yushengjin@uniontech.com>
 <20240924063258.1edfb590@fedora>
 <CANn89iLoBYjMmot=6e_WJrtEhcAzWikU2eV0eQExHPj7+ObGKA@mail.gmail.com>
 <20240924094054.2d005c76@fedora>
From: yushengjin <yushengjin@uniontech.com>
In-Reply-To: <20240924094054.2d005c76@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4a-0


在 25/9/2024 上午12:40, Stephen Hemminger 写道:
> On Tue, 24 Sep 2024 15:46:17 +0200
> Eric Dumazet <edumazet@google.com> wrote:
>
>> On Tue, Sep 24, 2024 at 3:33 PM Stephen Hemminger
>> <stephen@networkplumber.org> wrote:
>>> On Tue, 24 Sep 2024 17:09:06 +0800
>>> yushengjin <yushengjin@uniontech.com> wrote:
>>>   
>>>> When conducting WRK testing, the CPU usage rate of the testing machine was
>>>> 100%. forwarding through a bridge, if the network load is too high, it may
>>>> cause abnormal load on the ebt_do_table of the kernel ebtable module, leading
>>>> to excessive soft interrupts and sometimes even directly causing CPU soft
>>>> deadlocks.
>>>>
>>>> After analysis, it was found that the code of ebtables had not been optimized
>>>> for a long time, and the read-write locks inside still existed. However, other
>>>> arp/ip/ip6 tables had already been optimized a lot, and performance bottlenecks
>>>> in read-write locks had been discovered a long time ago.
>>>>
>>>> Ref link: https://lore.kernel.org/lkml/20090428092411.5331c4a1@nehalam/
>>>>
>>>> So I referred to arp/ip/ip6 modification methods to optimize the read-write
>>>> lock in ebtables.c.
>>> What about doing RCU instead, faster and safer.
>> Safer ? How so ?
>>
>> Stephen, we have used this stuff already in other netfilter components
>> since 2011
>>
>> No performance issue at all.
>>
> I was thinking that lockdep and analysis tools do better job looking at RCU.
> Most likely, the number of users of ebtables was small enough that nobody looked
> hard at it until now.

Even though there are few users of ebtables, there are still serious issues.
This is the data running on the arm Kunpeng-920 (96 cpus) machine,When I 
only run
wrk tests, the softirq of the system will rapidly increase to 25%:

02:50:07 PM  CPU %usr  %nice %sys %iowait %irq  %soft  %steal %guest  
%gnice %idle
02:50:25 PM  all    0.00    0.00    0.05    0.00    0.72 23.20    
0.00    0.00    0.00   76.03
02:50:26 PM  all    0.00    0.00    0.08    0.00    0.72 24.53    
0.00    0.00    0.00   74.67
02:50:27 PM  all    0.01    0.00    0.13    0.00    0.75 24.89    
0.00    0.00    0.00   74.23

If ebatlse queries, updates, and other operations are continuously 
executed at this time, softirq
will increase again to 50%:

02:52:23 PM  all    0.00    0.00    1.18    0.00    0.54 48.91    
0.00    0.00    0.00   49.36
02:52:24 PM  all    0.00    0.00    1.19    0.00    0.43 48.23    
0.00    0.00    0.00   50.15
02:52:25 PM  all    0.00    0.00    1.20    0.00    0.50 48.29    
0.00    0.00    0.00   50.01

More seriously, soft lockup may occur:

Message from syslogd@localhost at Sep 25 14:52:22 ...
  kernel:watchdog: BUG: soft lockup - CPU#88 stuck for 23s! [ebtables:3896]

So i think soft lockup is even more unbearable than performance.

>
>

