Return-Path: <sam@ravnborg.org>
Date: Sun, 22 Nov 2020 23:10:40 +0100
From: Sam Ravnborg <sam@ravnborg.org>
Message-ID: <20201122221040.GD566387@ravnborg.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <20201120105344.4345c14e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <202011201129.B13FDB3C@keescook>
 <20201120115142.292999b2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <202011220816.8B6591A@keescook>
 <9b57fd4914b46f38d54087d75e072d6e947cb56d.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b57fd4914b46f38d54087d75e072d6e947cb56d.camel@HansenPartnership.com>
Subject: Re: [Bridge] [PATCH 000/141] Fix fall-through warnings for Clang
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: alsa-devel@alsa-project.org, bridge@lists.linux-foundation.org, linux-iio@vger.kernel.org, linux-wireless@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-ide@vger.kernel.org, dm-devel@redhat.com, keyrings@vger.kernel.org, linux-mtd@lists.infradead.org, GR-everest-linux-l2@marvell.com, wcn36xx@lists.infradead.org, linux-i3c@lists.infradead.org, linux1394-devel@lists.sourceforge.net, linux-afs@lists.infradead.org, drbd-dev@lists.linbit.com, devel@driverdev.osuosl.org, linux-cifs@vger.kernel.org, rds-devel@oss.oracle.com, linux-scsi@vger.kernel.org, linux-acpi@vger.kernel.org, linux-rdma@vger.kernel.org, oss-drivers@netronome.com, linux-atm-general@lists.sourceforge.net, ceph-devel@vger.kernel.org, amd-gfx@lists.freedesktop.org, linux-stm32@st-md-mailman.stormreply.com, cluster-devel@redhat.com, usb-storage@lists.one-eyed-alien.net, linux-mmc@vger.kernel.org, coreteam@netfilter.org, intel-wired-lan@lists.osuosl.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-input@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, Jakub Kicinski <kuba@kernel.org>, linux-ext4@vger.kernel.org, netfilter-devel@vger.kernel.org, linux-media@vger.kernel.org, Kees Cook <keescook@chromium.org>, selinux@vger.kernel.org, linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, linux-sctp@vger.kernel.org, reiserfs-devel@vger.kernel.org, linux-geode@lists.infradead.org, linux-block@vger.kernel.org, linux-gpio@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-mediatek@lists.infradead.org, xen-devel@lists.xenproject.org, nouveau@lists.freedesktop.org, linux-hams@vger.kernel.org, Nathan Chancellor <natechancellor@gmail.com>, linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>, linux-watchdog@vger.kernel.org, GR-Linux-NIC-Dev@marvell.com, linux-mm@kvack.org, netdev@vger.kernel.org, linux-decnet-user@lists.sourceforge.net, samba-technical@lists.samba.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-security-module@vger.kernel.org, target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net, linux-crypto@vger.kernel.org, patches@opensource.cirrus.com, Joe Perches <joe@perches.com>, linux-integrity@vger.kernel.org, linux-hardening@vger.kernel.org, linux-nfs@vger.kernel.org, x86@kernel.org, linux-usb@vger.kernel.org

Hi James.

> > > If none of the 140 patches here fix a real bug, and there is no
> > > change to machine code then it sounds to me like a W=2 kind of a
> > > warning.
> > 
> > FWIW, this series has found at least one bug so far:
> > https://lore.kernel.org/lkml/CAFCwf11izHF=g1mGry1fE5kvFFFrxzhPSM6qKAO8gxSp=Kr_CQ@mail.gmail.com/
> 
> 
> Well, it's a problem in an error leg, sure, but it's not a really
> compelling reason for a 141 patch series, is it?  All that fixing this
> error will do is get the driver to print "oh dear there's a problem"
> under four more conditions than it previously did.

You are asking the wrong question here.

Yuo should ask  how many hours could have been saved by all the bugs
people have been fighting with and then fixed *before* the code
hit the kernel at all.

My personal experience is that I, more than once, have had errors
related to a missing break in my code. So this warnings is IMO a win.

And if we are only ~100 patches to have it globally enabled then it is a
no-brainer in my book.

	Sam
