Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=cmy8kJ6ct6T1SukLiCokpljPgEMbsvkU+nAeLQwTKTs=;
	b=N+4fBd8gSmGzCK+bdYisszD2EhHivrniQUSdylDj4SDD5X8q1l5eGrtjjic4nMtTKz
	LN9GURqFhDjbPMltb/i+e+Bs5EEhOgjxiqlvzDsE1gHm/jTHKnhqGpLk7mccubEIFjae
	3No3fp6MHZwQafxkjl9yZMdQRxsshPkqQipxw=
References: <20180720144826.29892-1-nikolay@cumulusnetworks.com>
	<20180720144826.29892-3-nikolay@cumulusnetworks.com>
	<20180720090259.751a82f4@xeon-e3>
	<CAJieiUikHsmGLnSv5dEc0POqmC2UbKZ4YpzSXd=Bkbd-vtNgQQ@mail.gmail.com>
	<5e2db5d0-2944-54a4-7705-49713a0602bc@lab.ntt.co.jp>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <649cf32d-68c1-dc2e-74fd-4659ce3203fd@cumulusnetworks.com>
Date: Mon, 23 Jul 2018 11:03:56 +0300
MIME-Version: 1.0
In-Reply-To: <5e2db5d0-2944-54a4-7705-49713a0602bc@lab.ntt.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 2/2] net: bridge: add support for
	backup port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>, Roopa Prabhu <roopa@cumulusnetworks.com>
Cc: netdev <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, Wilson Kok <wkok@cumulusnetworks.com>, Anuradha Karuppiah <anuradhak@cumulusnetworks.com>, David Miller <davem@davemloft.net>

On 23/07/18 09:15, Toshiaki Makita wrote:
> On 2018/07/21 1:41, Roopa Prabhu wrote:
>> On Fri, Jul 20, 2018 at 9:02 AM, Stephen Hemminger
>> <stephen@networkplumber.org> wrote:
>>> Trying to understand this.
>>>
>>> Is it the case that what you are trying to solve is the way MLAG
>>> and bridging interact on the Linux side or more a limitation of how
>>> switches operate?  Wouldn't this work?
>>
>> not a limitation. Its the way MLAG works on the switch side
>>
>>>
>>>                 br0 -- team0 -- eth1
>>>                              +- eth2
>>>
>>> The bridge would only have fdb entries for the team device.
>>> Why do eth1 and eth2 have to be master devices?  Why would eth1
>>> and eth2 need to be bridge ports.
>>
>>
>> Two switches acting in a MLAG pair are connected by the peerlink
>> interface which is a bridge port.
>>
>> the config on one of the switches looks like the below. The other
>> switch also has a similar config.
>> eth0 is connected to one port on the server. And the server is
>> connected to both switches.
>>
>>
>> br0 -- team0---eth0
>>       |
>>       -- switch-peerlink
>>
>> switch-peerlink becomes the failover/backport port when say team0 to
>> the server goes down.
> 
> I feel like this kind of diagram in commitlog would help us understand
> what you/Nikolay want to do. I was also not able to get why team/bonding
> is not an option reading commitlog. (Now I think I understand it thanks
> to Roopa's explanation.)
> 

Fair enough, I'll send v3 with Roopa's explanation and diagram added.

Thanks,
 Nik

