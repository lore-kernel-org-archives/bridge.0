Return-Path: <miguel.ojeda.sandonis@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Jbdr1BEjJUZERXYDOU4Gv/mlbgAbUhdHLiICpsfXV1E=;
 b=l+vUmSI7i0l7fGuVwLPE5fOuxSSHusFrOEG0e9vJ5rcmJlRUOrCYTNMgOLszTPHVi8
 kkm8fDq5tpugZyKejz3uk0cqdmJQS1mRaMRBkOrvbAyI5fs/P/fRtiJLDz+N02sHzTn9
 5/inSz1Fbn+KfojwxtYTlcXPJfmsrqKqTBJHlwr9t4EjDd547DXA4VcN7evdsnVsuQ6p
 BBfcG3FVJZcSml9If1GSG7EsdjE7zI8hFJDY7AHsK/qRYVzYo+XeozyqqdAfx+vCyNIu
 chiyZGm6NoHt+eS3/xbHVpbDRehhnbGG6wOdrUeu9OVynRP4/UUYeZuXMpT7icG9n0vb
 4oYg==
MIME-Version: 1.0
References: <202011201129.B13FDB3C@keescook>
 <20201120115142.292999b2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <202011220816.8B6591A@keescook>
 <9b57fd4914b46f38d54087d75e072d6e947cb56d.camel@HansenPartnership.com>
 <ca071decb87cc7e905411423c05a48f9fd2f58d7.camel@perches.com>
 <0147972a72bc13f3629de8a32dee6f1f308994b5.camel@HansenPartnership.com>
 <d8d1e9add08cdd4158405e77762d4946037208f8.camel@perches.com>
 <dbd2cb703ed9eefa7dde9281ea26ab0f7acc8afe.camel@HansenPartnership.com>
 <20201123130348.GA3119@embeddedor>
 <8f5611bb015e044fa1c0a48147293923c2d904e4.camel@HansenPartnership.com>
 <202011241327.BB28F12F6@keescook>
 <alpine.LNX.2.23.453.2011250859290.15@nippy.intranet>
In-Reply-To: <alpine.LNX.2.23.453.2011250859290.15@nippy.intranet>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 25 Nov 2020 00:15:54 +0100
Message-ID: <CANiq72nUt57u5DG9rH=DB0DzQH7U6-QbG-2Ou+PyCY=p=_Ggag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] [Intel-wired-lan] [PATCH 000/141] Fix fall-through
	warnings for Clang
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Finn Thain <fthain@telegraphics.com.au>
Cc: alsa-devel@alsa-project.org, bridge@lists.linux-foundation.org, target-devel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org, linux-wireless <linux-wireless@vger.kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>, James Bottomley <James.Bottomley@hansenpartnership.com>, linux-ide@vger.kernel.org, dm-devel@redhat.com, keyrings@vger.kernel.org, linux-mtd@lists.infradead.org, GR-everest-linux-l2@marvell.com, wcn36xx@lists.infradead.org, linux-i3c@lists.infradead.org, linux1394-devel@lists.sourceforge.net, linux-afs@lists.infradead.org, drbd-dev@lists.linbit.com, devel@driverdev.osuosl.org, linux-cifs@vger.kernel.org, rds-devel@oss.oracle.com, linux-scsi@vger.kernel.org, linux-acpi@vger.kernel.org, linux-rdma@vger.kernel.org, oss-drivers@netronome.com, linux-atm-general@lists.sourceforge.net, ceph-devel@vger.kernel.org, amd-gfx@lists.freedesktop.org, linux-stm32@st-md-mailman.stormreply.com, cluster-devel@redhat.com, usb-storage@lists.one-eyed-alien.net, linux-mmc@vger.kernel.org, coreteam@netfilter.org, intel-wired-lan@lists.osuosl.org, linux-input <linux-input@vger.kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Ext4 Developers List <linux-ext4@vger.kernel.org>, virtualization@lists.linux-foundation.org, netfilter-devel@vger.kernel.org, Linux Media Mailing List <linux-media@vger.kernel.org>, Kees Cook <keescook@chromium.org>, selinux@vger.kernel.org, linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, linux-sctp@vger.kernel.org, reiserfs-devel@vger.kernel.org, linux-geode@lists.infradead.org, linux-block@vger.kernel.org, linux-gpio@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-mediatek@lists.infradead.org, xen-devel@lists.xenproject.org, nouveau@lists.freedesktop.org, linux-hams@vger.kernel.org, Nathan Chancellor <natechancellor@gmail.com>, linux-can@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-hwmon@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>, linux-watchdog@vger.kernel.org, GR-Linux-NIC-Dev@marvell.com, Linux-MM <linux-mm@kvack.org>, Network Development <netdev@vger.kernel.org>, linux-decnet-user@lists.sourceforge.net, samba-technical@lists.samba.org, linux-kernel <linux-kernel@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, linux-security-module@vger.kernel.org, linux-usb@vger.kernel.org, tipc-discussion@lists.sourceforge.net, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, patches@opensource.cirrus.com, Joe Perches <joe@perches.com>, linux-integrity@vger.kernel.org, linux-nfs@vger.kernel.org, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, linux-hardening@vger.kernel.org

On Tue, Nov 24, 2020 at 11:24 PM Finn Thain <fthain@telegraphics.com.au> wrote:
>
> These statements are not "missing" unless you presume that code written
> before the latest de facto language spec was written should somehow be
> held to that spec.

There is no "language spec" the kernel adheres to. Even if it did,
kernel code is not frozen. If an improvement is found, it should be
applied.

> If the 'fallthrough' statement is not part of the latest draft spec then
> we should ask why not before we embrace it. Being that the kernel still
> prefers -std=gnu89 you might want to consider what has prevented
> -std=gnu99 or -std=gnu2x etc.

The C standard has nothing to do with this. We use compiler extensions
of several kinds, for many years. Even discounting those extensions,
the kernel is not even conforming to C due to e.g. strict aliasing. I
am not sure what you are trying to argue here.

But, since you insist: yes, the `fallthrough` attribute is in the
current C2x draft.

Cheers,
Miguel
