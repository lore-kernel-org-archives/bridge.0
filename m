Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:from:to:cc:references:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=mN4Hy8Pe7XdJN4US9s0ES1otIlKI++aQrbwu3fHJfC8=;
	b=VJIYSWgeMmjqoOH8dy96+lNVekgozZF7wzSVnelXIb7cHIjBspto8kmbU1OqHqCESl
	Yg2IgrkzOLK73gnT0l4zta0bhA4adwwXujdANmhzdUxzjGgb+pUeWeRIZCFEgfAMQEZ5
	XWGea9ad7peT/RyCv4VbcHocbGInv4aunA9GE=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
References: <001a113de2d878ade40569941a21@google.com>
	<CACT4Y+afuYwoWEp1PJ-Noo-YBXmKKRErntBWy2fR6iz=_xFByQ@mail.gmail.com>
	<20180426061314.GH20683@leo.usersys.redhat.com>
	<CACT4Y+aDko-kKP-u2S_UGBbB-uwnGw4dWTOSmXVDR3=osLJeFg@mail.gmail.com>
	<20180426103702.GI20683@leo.usersys.redhat.com>
	<2170a49c-be84-1bf4-4c73-bf7a668e5288@cumulusnetworks.com>
Message-ID: <90eb7466-35de-f1cf-c186-dc367ad5257f@cumulusnetworks.com>
Date: Thu, 26 Apr 2018 14:51:21 +0300
MIME-Version: 1.0
In-Reply-To: <2170a49c-be84-1bf4-4c73-bf7a668e5288@cumulusnetworks.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] WARNING: kobject bug in br_add_if
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hangbin Liu <liuhangbin@gmail.com>, Dmitry Vyukov <dvyukov@google.com>
Cc: netdev <netdev@vger.kernel.org>, syzbot <syzbot+de73361ee4971b6e6f75@syzkaller.appspotmail.com>, bridge@lists.linux-foundation.org, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Miller <davem@davemloft.net>

On 26/04/18 14:49, Nikolay Aleksandrov wrote:
> On 26/04/18 13:37, Hangbin Liu wrote:
>> On Thu, Apr 26, 2018 at 10:04:16AM +0200, Dmitry Vyukov wrote:
>>> On Thu, Apr 26, 2018 at 8:13 AM, Hangbin Liu <liuhangbin@gmail.com> wrote:
>>>> On Wed, Apr 11, 2018 at 05:18:23PM +0200, Dmitry Vyukov wrote:
>>>>> On Wed, Apr 11, 2018 at 5:15 PM, syzbot
>>>>> <syzbot+de73361ee4971b6e6f75@syzkaller.appspotmail.com> wrote:
>>>>>> kobject_add_internal failed for brport (error: -12 parent: bond0)
> [snip]
>>
>> Re-checked the error. This is a -ENOMEM. So normally we could ignore it.
>>
>> But on the other hand, although we could find out the slave iface's
>> master in netdev_master_upper_dev_link(). It already go much further
>> and allocate some resource and change iface state. e.g.
>>
>> [54273.968516] br0: port 1(em1) entered blocking state
>> [54273.973979] br0: port 1(em1) entered disabled state
>>
>> So I think we'd better return as early as possible. I will post a fix
>> for this.
>>
>> Thanks
>> Hangbin
> 
> If I'm not mistaken the bridge allocated resources for the port are
> cleaned on kobject_init_and_add() error return. Or are you talking
> about some other resources ?
> 

Ah, my bad - you weren't talking about resource freeing.
Nevermind my comment.

