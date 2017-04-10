Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=7MRo0rLcmcLL3aDvKMfnqmtdv9hw+BttxtPcIp6UxcE=;
	b=hUbNciUNC7uSNb1aPbves3zsfQ6F/hd9SdvW+uMx6w4fGduM2QVtFQdaUJwJynvgKm
	z+YWI19Yp73dUUnBDu4l/eLX3wYux3ObIA8vO5TVv5VRMqucGOwjhV7T4VuksZP0oXfd
	8YvTqi+fZM20BJBxBFZUQSMdstN9ElRTlyMsPjRwvCVi6FW2GJmjr07UBkn3sKcitA1V
	jH06j00ylgxrmTcaXLxT9CjOhkHuFl7QDcHxhcQ8FqdLuwGiHZJ+Ot3LOrtHHrEniMdB
	MBQjqu/ybHp/ehg+5rqQCupHr/usZmaMyJgS0XLfRw5G2v+Krnu7/5W+Ckf1bpsXX9WK
	pm+g==
Date: Mon, 10 Apr 2017 16:06:01 -0400
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20170410160601.67120d94@plumbers-lap.home.lan>
In-Reply-To: <20170410115928.9344-1-idosch@idosch.org>
References: <20170410115928.9344-1-idosch@idosch.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net v3 0/2] bridge: Fix kernel oops during
 bridge creation
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: idosch@idosch.org
Cc: mlxsw@mellanox.com, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, peter@svinota.eu, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@mellanox.com>, davem@davemloft.net

On Mon, 10 Apr 2017 14:59:26 +0300
idosch@idosch.org wrote:

> From: Ido Schimmel <idosch@mellanox.com>
> 
> First patch adds a missing ndo_uninit() in the bridge driver, which is a
> prerequisite for the second patch that actually fixes the oops.
> 
> Please consider both patches for 4.4.y, 4.9.y and 4.10.y
> 
> Ido Schimmel (2):
>   bridge: implement missing ndo_uninit()
>   bridge: netlink: register netdevice before executing changelink
> 
>  net/bridge/br_device.c    | 20 +++++++++++---------
>  net/bridge/br_if.c        |  1 -
>  net/bridge/br_multicast.c |  7 +++++--
>  net/bridge/br_netlink.c   |  7 +++++--
>  net/bridge/br_private.h   |  5 +++++
>  5 files changed, 26 insertions(+), 14 deletions(-)
> 

Looks good, thanks for following through on this.

Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
