Return-Path: <ecree.xilinx@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ha42UWMtlXOL8kfvC1XpFKttY73p7G2gxviD5bIo2Ac=;
 b=cK16XuXEr1UlZZi/GgHF7dItPstb+7yZ2QUTp5Dxvdc6OIX52ygirnUAKuRVBOH+dK
 A20pmgUIw2HuGZFFAXCmBSAdjpUAnHlbQW6vzVJQphFFEbO8NHcI7pY1E1IYv6o5k0Qf
 jXWsM0ddqTXTn/1nZTXycpkYVMfbhxZxJ9mV7kOEU+Tec/es0pgNM20lzmzFkZBYIURn
 HK2FiFuW7CXMZxeXIL3yJ5bCH/J8M2hkcorgk3PecLezXYs+oTw3zVRlNq6FEGJfSXMe
 e5NpXkmlA2dB6AmhViUGWqJQAiQop1G/7Q0C0bZUhlLDOGEFt9XX9+Dv47nZ0Rj6T1x/
 IsxA==
References: <cover.1605896059.git.gustavoars@kernel.org>
 <20201120105344.4345c14e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <202011201129.B13FDB3C@keescook>
 <20201120115142.292999b2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <202011220816.8B6591A@keescook>
 <CAKwvOdntVfXj2WRR5n6Kw7BfG7FdKpTeHeh5nPu5AzwVMhOHTg@mail.gmail.com>
 <202011241324.B3439A2@keescook>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <99a9ffd7-6356-b81d-6e08-7ed74b6fb82c@gmail.com>
Date: Wed, 25 Nov 2020 23:02:40 +0000
MIME-Version: 1.0
In-Reply-To: <202011241324.B3439A2@keescook>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH 000/141] Fix fall-through warnings for Clang
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Kees Cook <keescook@chromium.org>, Nick Desaulniers <ndesaulniers@google.com>
Cc: alsa-devel@alsa-project.org, linux-atm-general@lists.sourceforge.net, reiserfs-devel@vger.kernel.org, linux-iio@vger.kernel.org, linux-wireless <linux-wireless@vger.kernel.org>, linux-fbdev@vger.kernel.org, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, Nathan Chancellor <natechancellor@gmail.com>, linux-ide@vger.kernel.org, dm-devel@redhat.com, keyrings@vger.kernel.org, linux-mtd@lists.infradead.org, GR-everest-linux-l2@marvell.com, wcn36xx@lists.infradead.org, samba-technical@lists.samba.org, linux-i3c@lists.infradead.org, linux1394-devel@lists.sourceforge.net, linux-afs@lists.infradead.org, usb-storage@lists.one-eyed-alien.net, drbd-dev@lists.linbit.com, devel@driverdev.osuosl.org, linux-cifs@vger.kernel.org, rds-devel@oss.oracle.com, linux-scsi@vger.kernel.org, linux-rdma@vger.kernel.org, oss-drivers@netronome.com, bridge@lists.linux-foundation.org, linux-security-module@vger.kernel.org, amd-gfx list <amd-gfx@lists.freedesktop.org>, linux-stm32@st-md-mailman.stormreply.com, cluster-devel@redhat.com, linux-acpi@vger.kernel.org, coreteam@netfilter.org, intel-wired-lan@lists.osuosl.org, linux-input@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, Jakub Kicinski <kuba@kernel.org>, linux-ext4@vger.kernel.org, linux-media@vger.kernel.org, linux-watchdog@vger.kernel.org, selinux@vger.kernel.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>, intel-gfx@lists.freedesktop.org, linux-geode@lists.infradead.org, linux-can@vger.kernel.org, linux-block@vger.kernel.org, linux-gpio@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-mediatek@lists.infradead.org, xen-devel@lists.xenproject.org, nouveau@lists.freedesktop.org, linux-hams@vger.kernel.org, ceph-devel@vger.kernel.org, virtualization@lists.linux-foundation.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-hwmon@vger.kernel.org, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, linux-nfs@vger.kernel.org, GR-Linux-NIC-Dev@marvell.com, tipc-discussion@lists.sourceforge.net, Linux Memory Management List <linux-mm@kvack.org>, Network Development <netdev@vger.kernel.org>, linux-decnet-user@lists.sourceforge.net, linux-mmc@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, linux-sctp@vger.kernel.org, linux-usb@vger.kernel.org, netfilter-devel@vger.kernel.org, "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>, patches@opensource.cirrus.com, Joe Perches <joe@perches.com>, linux-integrity@vger.kernel.org, target-devel@vger.kernel.org, linux-hardening@vger.kernel.org

On 24/11/2020 21:25, Kees Cook wrote:
> I still think this isn't right -- it's a case statement that runs off
> the end without an explicit flow control determination.

Proves too much — for instance
    case foo:
    case bar:
        thing;
        break;
 doesn't require a fallthrough; after case foo:, and afaik
 no-one is suggesting it should.  Yet it, too, is "a case
 statement that runs off the end without an explicit flow
 control determination".

-ed
