Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LyKSxUlVMA95fPCFzLoOEQ63e1Qi+u1GuBh6ef/TJGg=;
 b=K5Txdhbci90g/30K8mIH4x9gZRVVcsRJlHL0y4BjYQ8X2UsnU8afyZtFaX07h4fK1T
 rJQhNVqjUIj9vgbee/PXGzr45P50YE8B3p+8B6pbzHv50ya7dkGDVik+6GVT581GBuJg
 VRLUsVMvhbwDhueWSWC50kLnCz3Pbd/46ZZuW1gf2uWEx1Gg1JYcoBxqFIt3vu7RRzjn
 vf+fiTh2BHdRksElcIdRfDbwS9doGE3utA1mJ3HRMwFsTnulZCaV34MAlpi6A02P08vA
 QiUGKpRZqMukH5ZFcZRwbMzmKIhQnbcJc9zMVkYvi4ssJl97SSm8/G4FLOQj76aViAHy
 IFow==
Date: Sun, 16 Feb 2020 09:47:07 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20200216094707.165f85bc@hermes.lan>
In-Reply-To: <bce2e3fb5e6061a926250b942a958f992b0d85bc.camel@uni-konstanz.de>
References: <bce2e3fb5e6061a926250b942a958f992b0d85bc.camel@uni-konstanz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Support for long interface names
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Marcel Waldvogel <marcel.waldvogel@uni-konstanz.de>
Cc: bridge@lists.linux-foundation.org

On Mon, 10 Feb 2020 16:00:49 +0100
Marcel Waldvogel <marcel.waldvogel@uni-konstanz.de> wrote:

> Hi,
> I've added support for long bridge interface names (such as"br-
> 0081a64f416f") to "brctl show" (long physical interface names arenot a
> problem there).
> Please find a branch with the commit at 
> https://github.com/MarcelWaldvogel/bridge-utils/tree/long-ifnames
> 
> -Marcel

Thanks but I have no plans to add any new features to bridge-utils.
Just like ifconfig, users should migrate to the new bridge command
in iproute2.
