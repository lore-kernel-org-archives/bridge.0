Return-Path: <miguel.ojeda.sandonis@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=H+rGPaoJ9R3rr7zK4cuxMwlBlLpdlGUAwlQnvIZjZd8=;
 b=rGjC6KnGzC9NIfLo6IfoTM7C5TiZmv4q08vYNRt8cewMWpFhbX886WW47/gIiopas/
 e2jKhT73QJs/dRAIbILcJdQSFnVW9dal1rOBoIKd0ECBe+nqcukIgJrBRfX2wbZlPbrR
 27L+0GE9CXpbAta7TZEIdoDweQHp+sEvmypYMH9hyutdrnRkkklGbspFfFiZY+HYfDHj
 jsH/8tjPy+0JiTdJWitSDoQxXZntWXoEWL0cWLR+fmdpM332GBoSCjfuWUHY88IWDiPh
 04ztpEPYlCjpB7IXy1yQhW/otwe7DgKcwtOpyIrk5XdAw3ZKiOAkll08YWpT8S+NhzMx
 e/Gw==
MIME-Version: 1.0
References: <cover.1605896059.git.gustavoars@kernel.org>
 <20201120105344.4345c14e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <202011201129.B13FDB3C@keescook>
 <20201120115142.292999b2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <202011220816.8B6591A@keescook>
 <9b57fd4914b46f38d54087d75e072d6e947cb56d.camel@HansenPartnership.com>
 <CANiq72nZrHWTA4_Msg6MP9snTyenC6-eGfD27CyfNSu7QoVZbw@mail.gmail.com>
 <alpine.LNX.2.23.453.2011230938390.7@nippy.intranet>
 <CANiq72=z+tmuey9wj3Kk7wX5s0hTHpsQdLhAqcOVNrHon6xn5Q@mail.gmail.com>
 <alpine.LNX.2.23.453.2011241036520.7@nippy.intranet>
In-Reply-To: <alpine.LNX.2.23.453.2011241036520.7@nippy.intranet>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 25 Nov 2020 00:46:23 +0100
Message-ID: <CANiq72=Ybm2MHmOizo1xQ_QYGuvbthtnLbwCkr8AFb8PcfmuQw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] [PATCH 000/141] Fix fall-through warnings for Clang
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Finn Thain <fthain@telegraphics.com.au>
Cc: alsa-devel@alsa-project.org, linux-atm-general@lists.sourceforge.net, reiserfs-devel@vger.kernel.org, linux-iio@vger.kernel.org, linux-wireless <linux-wireless@vger.kernel.org>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>, James Bottomley <James.Bottomley@hansenpartnership.com>, linux-ide@vger.kernel.org, dm-devel@redhat.com, keyrings@vger.kernel.org, linux-mtd@lists.infradead.org, GR-everest-linux-l2@marvell.com, wcn36xx@lists.infradead.org, samba-technical@lists.samba.org, linux-i3c@lists.infradead.org, linux1394-devel@lists.sourceforge.net, linux-afs@lists.infradead.org, usb-storage@lists.one-eyed-alien.net, drbd-dev@lists.linbit.com, devel@driverdev.osuosl.org, linux-cifs@vger.kernel.org, rds-devel@oss.oracle.com, Nick Desaulniers <ndesaulniers@google.com>, linux-scsi@vger.kernel.org, Nathan Chancellor <natechancellor@gmail.com>, linux-rdma@vger.kernel.org, oss-drivers@netronome.com, bridge@lists.linux-foundation.org, linux-security-module@vger.kernel.org, amd-gfx@lists.freedesktop.org, linux-stm32@st-md-mailman.stormreply.com, cluster-devel@redhat.com, linux-acpi@vger.kernel.org, coreteam@netfilter.org, intel-wired-lan@lists.osuosl.org, linux-input <linux-input@vger.kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Ext4 Developers List <linux-ext4@vger.kernel.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, Kees Cook <keescook@chromium.org>, selinux@vger.kernel.org, linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, linux-geode@lists.infradead.org, linux-can@vger.kernel.org, linux-block@vger.kernel.org, linux-gpio@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-mediatek@lists.infradead.org, xen-devel@lists.xenproject.org, nouveau@lists.freedesktop.org, linux-hams@vger.kernel.org, ceph-devel@vger.kernel.org, virtualization@lists.linux-foundation.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-hwmon@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-nfs@vger.kernel.org, GR-Linux-NIC-Dev@marvell.com, tipc-discussion@lists.sourceforge.net, Linux-MM <linux-mm@kvack.org>, Network Development <netdev@vger.kernel.org>, linux-decnet-user@lists.sourceforge.net, linux-mmc@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, linux-renesas-soc@vger.kernel.org, linux-sctp@vger.kernel.org, linux-usb@vger.kernel.org, netfilter-devel@vger.kernel.org, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, patches@opensource.cirrus.com, Joe Perches <joe@perches.com>, linux-integrity@vger.kernel.org, target-devel@vger.kernel.org, linux-hardening@vger.kernel.org

On Tue, Nov 24, 2020 at 1:58 AM Finn Thain <fthain@telegraphics.com.au> wrote:
>
> What I meant was that you've used pessimism as if it was fact.

"future mistakes that it might prevent" is neither pessimism nor states a fact.

> For example, "There is no way to guess what the effect would be if the
> compiler trained programmers to add a knee-jerk 'break' statement to avoid
> a warning".

It is only knee-jerk if you think you are infallible.

> Moreover, what I meant was that preventing programmer mistakes is a
> problem to be solved by development tools

This warning comes from a development tool -- the compiler.

> The idea that retro-fitting new
> language constructs onto mature code is somehow necessary to "prevent
> future mistakes" is entirely questionable.

The kernel is not a frozen codebase.

Further, "mature code vs. risk of change" arguments don't apply here
because the semantics of the program and binary output isn't changing.

> Sure. And if you put -Wimplicit-fallthrough into the Makefile and if that
> leads to well-intentioned patches that cause regressions, it is partly on
> you.

Again: adding a `fallthrough` does not change the program semantics.
If you are a maintainer and want to cross-check, compare the codegen.

> Have you ever considered the overall cost of the countless
> -Wpresume-incompetence flags?

Yeah: negative. On the other hand, the overall cost of the countless
-fI-am-infallible flags is very noticeable.

> Perhaps you pay the power bill for a build farm that produces logs that
> no-one reads? Perhaps you've run git bisect, knowing that the compiler
> messages are not interesting? Or compiled software in using a language
> that generates impenetrable messages? If so, here's a tip:
>
> # grep CFLAGS /etc/portage/make.conf
> CFLAGS="... -Wno-all -Wno-extra ..."
> CXXFLAGS="${CFLAGS}"
>
> Now allow me some pessimism: the hardware upgrades, gigawatt hours and
> wait time attributable to obligatory static analyses are a net loss.

If you really believe compiler warnings and static analysis are
useless and costly, I think there is not much point in continuing the
discussion.

> No, it's not for me to prove that such patches don't affect code
> generation. That's for the patch author and (unfortunately) for reviewers.

I was not asking you to prove it. I am stating that proving it is very easy.

Cheers,
Miguel
