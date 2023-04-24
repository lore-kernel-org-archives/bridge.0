Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6366460F6F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 11F2D61305
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJK4EkO7fWWh/YqKcNLoLvILD47QCm8kUErkkX7J1TM=;
 b=I+i/vpFcpJiJow74wHAAzp8XD95WpF4XuXStIXiN6k8u78eDxEauRPg7+jWlKBLd/Xf5THyaGdtYpN2etAFXVb/xaCTshodzyUPIPTjB2/2wyaAx+1+rfSKxzq8wWyT3dDwKgBbAEZFLS0e23sqRJGbjBASu+1LhoOnyn1ModGA2alzggSalNaM4+Fc/4XhXglHaBnNiHC9yiqE5Hna4I3CoDmGXdl79FRFcBAOZu3r5N0q8ZgJaEhVaAEIhI0HnGNSi/i23G/U107JoKZi90ulDiRxGrEnNtKsfJ/oR0FvK2MlfS4VAIPj1qE632xP9XnSFX6448KDIibtZPgtXCA==
Date: Mon, 24 Apr 2023 18:46:53 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <ZEakbR71vNuLnEFp@shredder>
References: <ZEZK9AkChoOF3Lys@Laptop-X1>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEZK9AkChoOF3Lys@Laptop-X1>
MIME-Version: 1.0
Subject: Re: [Bridge] [Question] Any plan to write/update the bridge doc?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Roopa Prabhu <roopa@nvidia.com>

On Mon, Apr 24, 2023 at 05:25:08PM +0800, Hangbin Liu wrote:
> Hi,
> 
> Maybe someone already has asked. The only official Linux bridge document I
> got is a very ancient wiki page[1] or the ip link man page[2][3]. As there are
> many bridge stp/vlan/multicast paramegers. Should we add a detailed kernel
> document about each parameter? The parameter showed in ip link page seems
> a little brief.

I suggest improving the man pages instead of adding kernel
documentation. The man pages are the most up to date resource and
therefore the one users probably refer to the most. Also, it's already
quite annoying to patch both "ip-link" and "bridge" man pages when
adding bridge port options. Adding a third document and making sure all
three resources are patched would be a nightmare...

> 
> I'd like to help do this work. But apparently neither my English nor my
> understanding of the code is good enough. Anyway, if you want, I can help
> write a draft version first and you (bridge maintainers) keep working on this.

I can help reviewing man page patches if you want. I'm going to send
some soon. Will copy you.

> 
> [1] https://wiki.linuxfoundation.org/networking/bridge
> [2] https://man7.org/linux/man-pages/man8/bridge.8.html
> [3] https://man7.org/linux/man-pages/man8/ip-link.8.html
> 
> Thanks
> Hangbin
