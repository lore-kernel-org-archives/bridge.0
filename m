Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=7Jb0pwWJsHp79SUl3WvPX+cFrdBR5jZlBmEMB71qay8=;
	b=M4rwFACyCjODb6Io9Hq3ksKm2Pd3yg4CaN24/5h/rrr01NoVDF/PiF51tltPetJ1+j
	IkBqJatB/jeXo6whixG2+ChrISQ+EkKOLPqP68vN2kgKi2iskYqSv+nsqzu2JI9iXkyS
	W1rszcXUG66MaLvFsk0CL3dDyeIFAL69JgVQ0=
References: <cover.1544614445.git.petrm@mellanox.com>
	<ec46d51de1641ef2fd012fd3474935d6ee72edaf.1544614445.git.petrm@mellanox.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <acdc5d71-e95d-e208-c141-a817b52b6097@cumulusnetworks.com>
Date: Wed, 12 Dec 2018 14:20:02 +0200
MIME-Version: 1.0
In-Reply-To: <ec46d51de1641ef2fd012fd3474935d6ee72edaf.1544614445.git.petrm@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 2/9] net: bridge: Propagate extack to
	switchdev
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Petr Machata <petrm@mellanox.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "ivecera@redhat.com" <ivecera@redhat.com>, Roopa Prabhu <roopa@cumulusnetworks.com>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, Ido Schimmel <idosch@mellanox.com>, Jiri Pirko <jiri@mellanox.com>, David Ahern <dsa@cumulusnetworks.com>, "davem@davemloft.net" <davem@davemloft.net>

On 12/12/2018 13:52, Petr Machata wrote:
> ndo_bridge_setlink has been updated in the previous patch to have extack
> available, and changelink RTNL op has had this argument since the time
> extack was added. Propagate both through the bridge driver to eventually
> reach br_switchdev_port_vlan_add(), where it will be used by subsequent
> patches.
> 
> Signed-off-by: Petr Machata <petrm@mellanox.com>
> Acked-by: Jiri Pirko <jiri@mellanox.com>
> ---
>  net/bridge/br_if.c        |  2 +-
>  net/bridge/br_netlink.c   | 27 +++++++++++++---------
>  net/bridge/br_private.h   | 22 ++++++++++--------
>  net/bridge/br_switchdev.c |  3 ++-
>  net/bridge/br_vlan.c      | 59 ++++++++++++++++++++++++++---------------------
>  5 files changed, 65 insertions(+), 48 deletions(-)
> 

+CC Roopa & bridge list

Looks good to me.
Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

