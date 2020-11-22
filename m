Return-Path: <keescook@chromium.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=9LoGd3XD212DnUOzzxWdBwAHKcFiABUM1eku/Z5s9PQ=;
 b=ECdUiFozoGotedNMltHxGvt7ELeQp/og9KGaJat0+erwcdPPWVCrU8KkW+JV4RYPeo
 GTWUobzmr0s313q/lzhn4jF5RxJP4nhZO/aj20hZaH8d/g/a456RbO+LKniOS4LntN7M
 GHx9cYZv8xWYKIg8n9C3ZJn+Q+L/6/s35hbx0=
Date: Sun, 22 Nov 2020 08:17:03 -0800
From: Kees Cook <keescook@chromium.org>
Message-ID: <202011220816.8B6591A@keescook>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <20201120105344.4345c14e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <202011201129.B13FDB3C@keescook>
 <20201120115142.292999b2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120115142.292999b2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Subject: Re: [Bridge] [PATCH 000/141] Fix fall-through warnings for Clang
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jakub Kicinski <kuba@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-atm-general@lists.sourceforge.net, reiserfs-devel@vger.kernel.org, linux-iio@vger.kernel.org, linux-wireless@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Nathan Chancellor <natechancellor@gmail.com>, linux-ide@vger.kernel.org, dm-devel@redhat.com, keyrings@vger.kernel.org, linux-mtd@lists.infradead.org, GR-everest-linux-l2@marvell.com, wcn36xx@lists.infradead.org, samba-technical@lists.samba.org, linux-i3c@lists.infradead.org, linux1394-devel@lists.sourceforge.net, linux-afs@lists.infradead.org, usb-storage@lists.one-eyed-alien.net, drbd-dev@lists.linbit.com, devel@driverdev.osuosl.org, linux-cifs@vger.kernel.org, rds-devel@oss.oracle.com, Nick Desaulniers <ndesaulniers@google.com>, linux-scsi@vger.kernel.org, linux-rdma@vger.kernel.org, oss-drivers@netronome.com, bridge@lists.linux-foundation.org, linux-security-module@vger.kernel.org, amd-gfx@lists.freedesktop.org, linux-stm32@st-md-mailman.stormreply.com, cluster-devel@redhat.com, linux-acpi@vger.kernel.org, coreteam@netfilter.org, intel-wired-lan@lists.osuosl.org, linux-input@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, tipc-discussion@lists.sourceforge.net, linux-ext4@vger.kernel.org, linux-media@vger.kernel.org, linux-watchdog@vger.kernel.org, selinux@vger.kernel.org, linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, linux-geode@lists.infradead.org, linux-can@vger.kernel.org, linux-block@vger.kernel.org, linux-gpio@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-mediatek@lists.infradead.org, xen-devel@lists.xenproject.org, nouveau@lists.freedesktop.org, linux-hams@vger.kernel.org, ceph-devel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org, x86@kernel.org, linux-nfs@vger.kernel.org, GR-Linux-NIC-Dev@marvell.com, linux-mm@kvack.org, netdev@vger.kernel.org, linux-decnet-user@lists.sourceforge.net, linux-mmc@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-renesas-soc@vger.kernel.org, linux-sctp@vger.kernel.org, linux-usb@vger.kernel.org, netfilter-devel@vger.kernel.org, linux-crypto@vger.kernel.org, patches@opensource.cirrus.com, Joe Perches <joe@perches.com>, linux-integrity@vger.kernel.org, target-devel@vger.kernel.org, linux-hardening@vger.kernel.org

On Fri, Nov 20, 2020 at 11:51:42AM -0800, Jakub Kicinski wrote:
> On Fri, 20 Nov 2020 11:30:40 -0800 Kees Cook wrote:
> > On Fri, Nov 20, 2020 at 10:53:44AM -0800, Jakub Kicinski wrote:
> > > On Fri, 20 Nov 2020 12:21:39 -0600 Gustavo A. R. Silva wrote:  
> > > > This series aims to fix almost all remaining fall-through warnings in
> > > > order to enable -Wimplicit-fallthrough for Clang.
> > > > 
> > > > In preparation to enable -Wimplicit-fallthrough for Clang, explicitly
> > > > add multiple break/goto/return/fallthrough statements instead of just
> > > > letting the code fall through to the next case.
> > > > 
> > > > Notice that in order to enable -Wimplicit-fallthrough for Clang, this
> > > > change[1] is meant to be reverted at some point. So, this patch helps
> > > > to move in that direction.
> > > > 
> > > > Something important to mention is that there is currently a discrepancy
> > > > between GCC and Clang when dealing with switch fall-through to empty case
> > > > statements or to cases that only contain a break/continue/return
> > > > statement[2][3][4].  
> > > 
> > > Are we sure we want to make this change? Was it discussed before?
> > > 
> > > Are there any bugs Clangs puritanical definition of fallthrough helped
> > > find?
> > > 
> > > IMVHO compiler warnings are supposed to warn about issues that could
> > > be bugs. Falling through to default: break; can hardly be a bug?!  
> > 
> > It's certainly a place where the intent is not always clear. I think
> > this makes all the cases unambiguous, and doesn't impact the machine
> > code, since the compiler will happily optimize away any behavioral
> > redundancy.
> 
> If none of the 140 patches here fix a real bug, and there is no change
> to machine code then it sounds to me like a W=2 kind of a warning.

FWIW, this series has found at least one bug so far:
https://lore.kernel.org/lkml/CAFCwf11izHF=g1mGry1fE5kvFFFrxzhPSM6qKAO8gxSp=Kr_CQ@mail.gmail.com/

-- 
Kees Cook
