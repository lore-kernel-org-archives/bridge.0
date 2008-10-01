Message-ID: <fed120860810011401i33a7d752qd5abf1490b3900f4@mail.gmail.com>
Date: Thu, 2 Oct 2008 02:31:04 +0530
From: "Srinivas M.A." <srinivas.aji@gmail.com>
In-Reply-To: <20081001173246.5ee6696e@speedy>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6f6192b30810010757j408cbcb7jd5ee33b8da832cbe@mail.gmail.com>
	<20081001173246.5ee6696e@speedy>
Subject: Re: [Bridge] RSTP location and GPL info
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: M T <m.t.linuxbridge@gmail.com>
Cc: Stephen Hemminger <shemminger@vyatta.com>, bridge@lists.linux-foundation.org

MT,

The rstplib/ directory in Stephen's git repo is the RSTPLIB library
also available at sourceforge (http://rstplib.sourceforge.net/), but
with some small modifications for our purposes.
RSTPLIB itself is under LGPL, and if you intend to use it, it may be
better to start with the original version from sourceforge.

I wrote another RSTP library to replace RSTPLIB and be compliant with
802.1D-2004. I have not hosted that anywhere yet. That library is
licensed, together with the rest of my RSTP work, as GPL v >= 2.

I will email that to you separately to avoid the attachment on the mailing list.

On Wed, Oct 1, 2008 at 9:02 PM, Stephen Hemminger <shemminger@vyatta.com> wrote:
> On Wed, 1 Oct 2008 10:57:42 -0400
> "M T" <m.t.linuxbridge@gmail.com> wrote:
>
>> I am currently working on a project for work where I need to implement RSTP
>> on non-Linux platforms (possibly ThreadX). I saw that there was a form by
>> Mr. Srinivas Aji that implemented RSTP on Linux Bridge. Can someone please
>> tell me if that fork is somewhere on the kernel.org git repository?
>>
>> I would like to use this work (without changing any code). I don't
>> understand the intricacies of GPL.
>>
>> * Can someone please point me to resources that say what I can and cannot
>> use in my project?
>> * I cannot open source my project but I am willing to contribute back any
>> changes I make to portions of linux bridge. I don't mind testing it on linux
>> before submitting changes. Is this alright?
>> * Also, I just need to use portions of the project. For example, I only care
>> about the state machines and not the interaction with the Linux OS. Can I
>> just use bits and pieces of the linux bridge project?
>>
>> Thanks,
>> MT
>
> Did you look at
> git://git.kernel.org/pub/scm/linux/kernel/git/shemminger/rstp.git
>
> It is GPL v2.
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>
