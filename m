Return-Path: <dan.carpenter@oracle.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=CVxJrJvszPiYRoVvo8QMoaANjq0rT1w3VAIVepGqitY=;
 b=Q8Pq03hifJp4hxcZYQuiJvbKTKZMKP2mLNTS1aHW6hAxlDpObu2xNteC6Yj/L36I1kmY
 WSfMJZMdSk8bN2J9+UmYiF9MWo5KvhVT37I7ctRf5KKEocNW4v8PFVCDeiU3k6pn404k
 Igra+V15xZpvhIpriUlAo6fac2mI985JVt4CqtU5vfkzzkfANqieFePUQJBzO6eRndXt
 r4RGB+aUeJDKgHUaSwwmUD5k/B0oZ1T+RFudNU+Upzz4yF4kbfdExpcaXwIzXbiJCqdd
 NFMbLYQpnYBf2dU4wooUhfeXNwTuWm/ESbR6RxVNN2eeS+ZfeOwZNtuQUXq4Dn72Z2fB vg== 
Date: Tue, 1 Dec 2020 17:08:49 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Message-ID: <20201201140849.GH2767@kadam>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <20201120105344.4345c14e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <202011201129.B13FDB3C@keescook>
 <20201120115142.292999b2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <202011220816.8B6591A@keescook>
 <CAKwvOdntVfXj2WRR5n6Kw7BfG7FdKpTeHeh5nPu5AzwVMhOHTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdntVfXj2WRR5n6Kw7BfG7FdKpTeHeh5nPu5AzwVMhOHTg@mail.gmail.com>
Subject: Re: [Bridge] [PATCH 000/141] Fix fall-through warnings for Clang
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: alsa-devel@alsa-project.org, bridge@lists.linux-foundation.org, target-devel@vger.kernel.org, linux-iio@vger.kernel.org, linux-wireless <linux-wireless@vger.kernel.org>, linux-fbdev@vger.kernel.org, dri-devel <dri-devel@lists.freedesktop.org>, virtualization@lists.linux-foundation.org, Linux Memory Management List <linux-mm@kvack.org>, linux-ide@vger.kernel.org, dm-devel@redhat.com, keyrings@vger.kernel.org, linux-mtd@lists.infradead.org, GR-everest-linux-l2@marvell.com, wcn36xx@lists.infradead.org, linux-i3c@lists.infradead.org, linux1394-devel@lists.sourceforge.net, linux-afs@lists.infradead.org, linux-watchdog@vger.kernel.org, devel@driverdev.osuosl.org, linux-cifs@vger.kernel.org, rds-devel@oss.oracle.com, linux-scsi@vger.kernel.org, linux-acpi@vger.kernel.org, linux-rdma@vger.kernel.org, oss-drivers@netronome.com, linux-atm-general@lists.sourceforge.net, ceph-devel@vger.kernel.org, amd-gfx list <amd-gfx@lists.freedesktop.org>, linux-stm32@st-md-mailman.stormreply.com, cluster-devel@redhat.com, usb-storage@lists.one-eyed-alien.net, linux-mmc@vger.kernel.org, coreteam@netfilter.org, intel-wired-lan@lists.osuosl.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-input@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, Jakub Kicinski <kuba@kernel.org>, linux-ext4@vger.kernel.org, netfilter-devel@vger.kernel.org, linux-media@vger.kernel.org, Kees Cook <keescook@chromium.org>, selinux@vger.kernel.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>, intel-gfx@lists.freedesktop.org, linux-sctp@vger.kernel.org, reiserfs-devel@vger.kernel.org, linux-geode@lists.infradead.org, linux-block@vger.kernel.org, linux-gpio@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-mediatek@lists.infradead.org, xen-devel@lists.xenproject.org, drbd-dev@tron.linbit.com, linux-hams@vger.kernel.org, Nathan Chancellor <natechancellor@gmail.com>, linux-can@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-hwmon@vger.kernel.org, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, linux-nfs@vger.kernel.org, GR-Linux-NIC-Dev@marvell.com, nouveau@lists.freedesktop.org, Network Development <netdev@vger.kernel.org>, linux-decnet-user@lists.sourceforge.net, samba-technical@lists.samba.org, LKML <linux-kernel@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, linux-security-module@vger.kernel.org, linux-usb@vger.kernel.org, tipc-discussion@lists.sourceforge.net, "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>, patches@opensource.cirrus.com, Joe Perches <joe@perches.com>, linux-integrity@vger.kernel.org, linux-hardening@vger.kernel.org

On Mon, Nov 23, 2020 at 05:32:51PM -0800, Nick Desaulniers wrote:
> On Sun, Nov 22, 2020 at 8:17 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Fri, Nov 20, 2020 at 11:51:42AM -0800, Jakub Kicinski wrote:
> > > If none of the 140 patches here fix a real bug, and there is no change
> > > to machine code then it sounds to me like a W=2 kind of a warning.
> >
> > FWIW, this series has found at least one bug so far:
> > https://lore.kernel.org/lkml/CAFCwf11izHF=g1mGry1fE5kvFFFrxzhPSM6qKAO8gxSp=Kr_CQ@mail.gmail.com/
> 
> So looks like the bulk of these are:
> switch (x) {
>   case 0:
>     ++x;
>   default:
>     break;
> }

This should not generate a warning.

> 
> I have a patch that fixes those up for clang:
> https://reviews.llvm.org/D91895
> 
> There's 3 other cases that don't quite match between GCC and Clang I
> observe in the kernel:
> switch (x) {
>   case 0:
>     ++x;
>   default:
>     goto y;
> }
> y:;

This should generate a warning.

> 
> switch (x) {
>   case 0:
>     ++x;
>   default:
>     return;
> }

Warn for this.


> 
> switch (x) {
>   case 0:
>     ++x;
>   default:
>     ;
> }

Don't warn for this.

If adding a break statement changes the flow of the code then warn about
potentially missing break statements, but if it doesn't change anything
then don't warn about it.

regards,
dan carpenter
