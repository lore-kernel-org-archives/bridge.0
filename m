Return-Path: <martin.petersen@oracle.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=1e3cV7XKyt5cBPHNeWYhYMHu3W87CKppja6U1Jvw5F4=;
 b=V+G180Fh0lHbcmydQJqS5i+cerb42SoRrRI9QCXlQMjyWKKfj0acXqExTQUiK+7OEtft
 OuMy/8L57grCegXY4FPi2mfpdUD9NETOrjU6XyLEGnB6yCKU9e30d2WSgQTsYBxq/cMN
 5junVfgiRpfFB5rc1EfDtZHP43anCs3FIrUtz16u4yPsKG0NCInMT5yeMTaPCX1MMJeq
 qZ1GHIcbwNatFRQ/tELhwJDJybfqjlIskC/pDoCLpTPJ2KTrod7PX9rst5aaRTC3xIQA
 veh/+mbPHLjYXfePq5oiUCHv2+7Gowf8M2KKiHFzojpZKSSSQD2meZy2nTRpI8CVh6TQ Yg== 
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Date: Mon,  7 Dec 2020 23:52:01 -0500
Message-Id: <160740299787.710.4201881220590518200.b4-ty@oracle.com>
In-Reply-To: <cover.1605896059.git.gustavoars@kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] (subset) [PATCH 000/141] Fix fall-through warnings for
	Clang
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-fbdev@vger.kernel.org, linux-atm-general@lists.sourceforge.net, linux-stm32@st-md-mailman.stormreply.com, linux-iio@vger.kernel.org, linux-wireless@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, linux-ide@vger.kernel.org, dm-devel@redhat.com, keyrings@vger.kernel.org, linux-mtd@lists.infradead.org, linux-hardening@vger.kernel.org, wcn36xx@lists.infradead.org, linux-i3c@lists.infradead.org, linux-decnet-user@lists.sourceforge.net, ceph-devel@vger.kernel.org, usb-storage@lists.one-eyed-alien.net, Kees Cook <keescook@chromium.org>, devel@driverdev.osuosl.org, linux-cifs@vger.kernel.org, rds-devel@oss.oracle.com, linux1394-devel@lists.sourceforge.net, linux-scsi@vger.kernel.org, linux-rdma@vger.kernel.org, oss-drivers@netronome.com, x86@kernel.org, amd-gfx@lists.freedesktop.org, linux-afs@lists.infradead.org, cluster-devel@redhat.com, linux-acpi@vger.kernel.org, coreteam@netfilter.org, intel-wired-lan@lists.osuosl.org, linux-input@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org, linux-media@vger.kernel.org, bridge@lists.linux-foundation.org, linux-watchdog@vger.kernel.org, selinux@vger.kernel.org, linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, reiserfs-devel@vger.kernel.org, linux-geode@lists.infradead.org, linux-block@vger.kernel.org, linux-gpio@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-mediatek@lists.infradead.org, samba-technical@lists.samba.org, drbd-dev@tron.linbit.com, linux-hams@vger.kernel.org, Nathan Chancellor <natechancellor@gmail.com>, linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org, linux-mmc@vger.kernel.org, linux-nfs@vger.kernel.org, GR-Linux-NIC-Dev@marvell.com, tipc-discussion@lists.sourceforge.net, "Martin K . Petersen" <martin.petersen@oracle.com>, nouveau@lists.freedesktop.org, patches@opensource.cirrus.com, linux-usb@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>, linux-sctp@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-security-module@vger.kernel.org, target-devel@vger.kernel.org, netfilter-devel@vger.kernel.org, linux-crypto@vger.kernel.org, netdev@vger.kernel.org, Joe Perches <joe@perches.com>, linux-integrity@vger.kernel.org, GR-everest-linux-l2@marvell.com

On Fri, 20 Nov 2020 12:21:39 -0600, Gustavo A. R. Silva wrote:

> This series aims to fix almost all remaining fall-through warnings in
> order to enable -Wimplicit-fallthrough for Clang.
> 
> In preparation to enable -Wimplicit-fallthrough for Clang, explicitly
> add multiple break/goto/return/fallthrough statements instead of just
> letting the code fall through to the next case.
> 
> [...]

Applied to 5.11/scsi-queue, thanks!

[054/141] target: Fix fall-through warnings for Clang
          https://git.kernel.org/mkp/scsi/c/492096ecfa39

-- 
Martin K. Petersen	Oracle Linux Engineering
