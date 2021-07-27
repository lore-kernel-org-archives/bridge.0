Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627416014;
 bh=7gbluUXqRRDrRRn0YT85HoIea0afHl4fXkBq3wS8myc=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=ZuKh0QZIr0bo4IkkVxJ+KGIS7CN6C3qN0vMjFXehfb5lPWADe0PwPwsnk1qMM5vvO
 HlWCTVM4ZzSaJEPtmoNUa1vsliz463WcrdCQN1lkHHswUKgaNNtq29styVqu3BjN7r
 JYjOpWXSrkVvfQxj9Ek6rU+aJOXdBkncGx3bb9Y1mzLSX2u2tkkakG1hfNRYcUUq4e
 inTy+HHa8/MPQbmrfH3/IPLKgDL9lIMIjHc7+pUM2DHjS9wtjN7iT01LHakbA2lpny
 sQF0HUZcKsDMvVwqgSaSNCqv1JR5iOvrYNY91Aq7W+oxmNXRaUF211VLnU6VOI+NyL
 UUZx8tXVJZbzw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <162741601391.17427.11630081272562695042.git-patchwork-notify@kernel.org>
Date: Tue, 27 Jul 2021 20:00:13 +0000
References: <20210727134517.1384504-1-arnd@kernel.org>
In-Reply-To: <20210727134517.1384504-1-arnd@kernel.org>
Subject: Re: [Bridge] [PATCH net-next v3 00/31] ndo_ioctl rework
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Arnd Bergmann <arnd@kernel.org>
Cc: andrew@lunn.ch, linux-ppp@vger.kernel.org, hch@lst.de, qiang.zhao@nxp.com, steffen.klassert@secunet.com, linux-s390@vger.kernel.org, herbert@gondor.apana.org.au, linux-x25@vger.kernel.org, davem@davemloft.net, bridge@lists.linux-foundation.org, jwi@linux.ibm.com, linux-hippi@sunsite.dk, vfalico@gmail.com, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, jpr@f6fbb.org, jreuter@yaina.de, jes@trained-monkey.org, ms@dev.tdt.de, arnd@arndb.de, j@w1.fi, j.vosburgh@gmail.com, linux-mediatek@lists.infradead.org, courmisch@gmail.com, linux-hams@vger.kernel.org, kvalo@codeaurora.org, linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org, yoshfuji@linux-ipv6.org, netdev@vger.kernel.org, dsahern@kernel.org, linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, kevin.curtis@farsite.co.uk, t.sailer@alumni.ethz.ch, rajur@chelsio.com, kgraul@linux.ibm.com, khc@pm.waw.pl

Hello:

This series was applied to netdev/net-next.git (refs/heads/master):

On Tue, 27 Jul 2021 15:44:46 +0200 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This series is a follow-up to the series for removing
> compat_alloc_user_space() and copy_in_user() that has now
> been merged.
> 
> I wanted to be sure I address all the ways that 'struct ifreq' is used
> in device drivers through .ndo_do_ioctl, originally to prove that
> my approach of changing the struct definition was correct, but then
> I discarded that approach and went on anyway.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,01/31] net: split out SIOCDEVPRIVATE handling from dev_ioctl
    https://git.kernel.org/netdev/net-next/c/b9067f5dc4a0
  - [net-next,v3,02/31] staging: rtlwifi: use siocdevprivate
    https://git.kernel.org/netdev/net-next/c/89939e890605
  - [net-next,v3,03/31] staging: wlan-ng: use siocdevprivate
    https://git.kernel.org/netdev/net-next/c/3343c49a959d
  - [net-next,v3,04/31] hostap: use ndo_siocdevprivate
    https://git.kernel.org/netdev/net-next/c/3f3fa5340745
  - [net-next,v3,05/31] bridge: use ndo_siocdevprivate
    https://git.kernel.org/netdev/net-next/c/561d8352818f
  - [net-next,v3,06/31] phonet: use siocdevprivate
    https://git.kernel.org/netdev/net-next/c/4747c1a8bc50
  - [net-next,v3,07/31] tulip: use ndo_siocdevprivate
    https://git.kernel.org/netdev/net-next/c/029a4fef6b22
  - [net-next,v3,08/31] bonding: use siocdevprivate
    https://git.kernel.org/netdev/net-next/c/232ec98ec35d
  - [net-next,v3,09/31] appletalk: use ndo_siocdevprivate
    https://git.kernel.org/netdev/net-next/c/dbecb011eb78
  - [net-next,v3,10/31] hamachi: use ndo_siocdevprivate
    https://git.kernel.org/netdev/net-next/c/99b78a37a371
  - [net-next,v3,11/31] tehuti: use ndo_siocdevprivate
    https://git.kernel.org/netdev/net-next/c/32d05468c462
  - [net-next,v3,12/31] eql: use ndo_siocdevprivate
    https://git.kernel.org/netdev/net-next/c/d92f7b59d32b
  - [net-next,v3,13/31] fddi: use ndo_siocdevprivate
    https://git.kernel.org/netdev/net-next/c/043393d8b478
  - [net-next,v3,14/31] net: usb: use ndo_siocdevprivate
    https://git.kernel.org/netdev/net-next/c/ef1b5b0c30bc
  - [net-next,v3,15/31] slip/plip: use ndo_siocdevprivate
    https://git.kernel.org/netdev/net-next/c/76b5878cffab
  - [net-next,v3,16/31] qeth: use ndo_siocdevprivate
    https://git.kernel.org/netdev/net-next/c/18787eeebd71
  - [net-next,v3,17/31] cxgb3: use ndo_siocdevprivate
    https://git.kernel.org/netdev/net-next/c/ebb4a911e09a
  - [net-next,v3,18/31] hamradio: use ndo_siocdevprivate
    https://git.kernel.org/netdev/net-next/c/25ec92fbdd23
  - [net-next,v3,19/31] airo: use ndo_siocdevprivate
    https://git.kernel.org/netdev/net-next/c/ae6af0120dda
  - [net-next,v3,20/31] ip_tunnel: use ndo_siocdevprivate
    https://git.kernel.org/netdev/net-next/c/3e7a1c7c561e
  - [net-next,v3,21/31] hippi: use ndo_siocdevprivate
    https://git.kernel.org/netdev/net-next/c/81a68110a22a
  - [net-next,v3,22/31] sb1000: use ndo_siocdevprivate
    https://git.kernel.org/netdev/net-next/c/cc0aa831a0d9
  - [net-next,v3,23/31] ppp: use ndo_siocdevprivate
    https://git.kernel.org/netdev/net-next/c/34f7cac07c4e
  - [net-next,v3,24/31] wan: use ndo_siocdevprivate
    https://git.kernel.org/netdev/net-next/c/73d74f61a559
  - [net-next,v3,25/31] wan: cosa: remove dead cosa_net_ioctl() function
    https://git.kernel.org/netdev/net-next/c/8fb75b79cd98
  - [net-next,v3,26/31] dev_ioctl: pass SIOCDEVPRIVATE data separately
    https://git.kernel.org/netdev/net-next/c/a554bf96b49d
  - [net-next,v3,27/31] dev_ioctl: split out ndo_eth_ioctl
    https://git.kernel.org/netdev/net-next/c/a76053707dbf
  - [net-next,v3,28/31] net: split out ndo_siowandev ioctl
    https://git.kernel.org/netdev/net-next/c/ad7eab2ab014
  - [net-next,v3,29/31] net: socket: return changed ifreq from SIOCDEVPRIVATE
    https://git.kernel.org/netdev/net-next/c/88fc023f7de2
  - [net-next,v3,30/31] net: bridge: move bridge ioctls out of .ndo_do_ioctl
    https://git.kernel.org/netdev/net-next/c/ad2f99aedf8f
  - [net-next,v3,31/31] net: bonding: move ioctl handling to private ndo operation
    https://git.kernel.org/netdev/net-next/c/3d9d00bd1885

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


