Return-Path: <ndesaulniers@google.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1Fpt+3NGNjcuXPoKd+YKzvfWCCI+i2QS11ln4xb/K2c=;
 b=mZ10EKN9Q6HwSmECmmsUHbUHF/oTLT4c/YpQVGCE0gPLnlz6SgHQW3ieQ7zeUHJnUi
 XUPs+F1GoZaFLBKWU3CvMTPUTS8a5+RdM3NBjgdsJpNB5L7Gee8a5rDblh6bnWIWT9TK
 uir+AjWjaGJnRAA0K84IM0yu+WQnaSePUaJNJPiE7LfLBhB3Pd0A4gWblql3Lao7defI
 n9Uw15itvZVSId22hyle+f6GM1M4THjCwMgL7v1hyU5f7oNm+YC3/Fk6KnTIGBq7Lgby
 +eM5Ju8Jh9l5BxBe3HwjA5bt+bnUjVm7e9zM9zQUlIbVcSVLiqKYS2m+arIIzBAIXu/j
 s+uw==
MIME-Version: 1.0
References: <cover.1605896059.git.gustavoars@kernel.org>
 <20201120105344.4345c14e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <202011201129.B13FDB3C@keescook>
 <20201120115142.292999b2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <202011220816.8B6591A@keescook>
In-Reply-To: <202011220816.8B6591A@keescook>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 23 Nov 2020 17:32:51 -0800
Message-ID: <CAKwvOdntVfXj2WRR5n6Kw7BfG7FdKpTeHeh5nPu5AzwVMhOHTg@mail.gmail.com>
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
To: Kees Cook <keescook@chromium.org>
Cc: alsa-devel@alsa-project.org, linux-atm-general@lists.sourceforge.net, reiserfs-devel@vger.kernel.org, linux-iio@vger.kernel.org, linux-wireless <linux-wireless@vger.kernel.org>, linux-fbdev@vger.kernel.org, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, Nathan Chancellor <natechancellor@gmail.com>, linux-ide@vger.kernel.org, dm-devel@redhat.com, keyrings@vger.kernel.org, linux-mtd@lists.infradead.org, GR-everest-linux-l2@marvell.com, wcn36xx@lists.infradead.org, samba-technical@lists.samba.org, linux-i3c@lists.infradead.org, linux1394-devel@lists.sourceforge.net, linux-afs@lists.infradead.org, usb-storage@lists.one-eyed-alien.net, drbd-dev@lists.linbit.com, devel@driverdev.osuosl.org, linux-cifs@vger.kernel.org, rds-devel@oss.oracle.com, linux-scsi@vger.kernel.org, linux-rdma@vger.kernel.org, oss-drivers@netronome.com, bridge@lists.linux-foundation.org, linux-security-module@vger.kernel.org, amd-gfx list <amd-gfx@lists.freedesktop.org>, linux-stm32@st-md-mailman.stormreply.com, cluster-devel@redhat.com, linux-acpi@vger.kernel.org, coreteam@netfilter.org, intel-wired-lan@lists.osuosl.org, linux-input@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, Jakub Kicinski <kuba@kernel.org>, linux-ext4@vger.kernel.org, linux-media@vger.kernel.org, linux-watchdog@vger.kernel.org, selinux@vger.kernel.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>, intel-gfx@lists.freedesktop.org, linux-geode@lists.infradead.org, linux-can@vger.kernel.org, linux-block@vger.kernel.org, linux-gpio@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-mediatek@lists.infradead.org, xen-devel@lists.xenproject.org, nouveau@lists.freedesktop.org, linux-hams@vger.kernel.org, ceph-devel@vger.kernel.org, virtualization@lists.linux-foundation.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-hwmon@vger.kernel.org, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, linux-nfs@vger.kernel.org, GR-Linux-NIC-Dev@marvell.com, tipc-discussion@lists.sourceforge.net, Linux Memory Management List <linux-mm@kvack.org>, Network Development <netdev@vger.kernel.org>, linux-decnet-user@lists.sourceforge.net, linux-mmc@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, linux-sctp@vger.kernel.org, linux-usb@vger.kernel.org, netfilter-devel@vger.kernel.org, "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>, patches@opensource.cirrus.com, Joe Perches <joe@perches.com>, linux-integrity@vger.kernel.org, target-devel@vger.kernel.org, linux-hardening@vger.kernel.org

On Sun, Nov 22, 2020 at 8:17 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Nov 20, 2020 at 11:51:42AM -0800, Jakub Kicinski wrote:
> > If none of the 140 patches here fix a real bug, and there is no change
> > to machine code then it sounds to me like a W=2 kind of a warning.
>
> FWIW, this series has found at least one bug so far:
> https://lore.kernel.org/lkml/CAFCwf11izHF=g1mGry1fE5kvFFFrxzhPSM6qKAO8gxSp=Kr_CQ@mail.gmail.com/

So looks like the bulk of these are:
switch (x) {
  case 0:
    ++x;
  default:
    break;
}

I have a patch that fixes those up for clang:
https://reviews.llvm.org/D91895

There's 3 other cases that don't quite match between GCC and Clang I
observe in the kernel:
switch (x) {
  case 0:
    ++x;
  default:
    goto y;
}
y:;

switch (x) {
  case 0:
    ++x;
  default:
    return;
}

switch (x) {
  case 0:
    ++x;
  default:
    ;
}

Based on your link, and Nathan's comment on my patch, maybe Clang
should continue to warn for the above (at least the `default: return;`
case) and GCC should change?  While the last case looks harmless,
there were only 1 or 2 across the tree in my limited configuration
testing; I really think we should just add `break`s for those.
-- 
Thanks,
~Nick Desaulniers
