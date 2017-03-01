Return-Path: <roopa@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=message-id:date:from:user-agent:mime-version:to:cc:subject
	:references:in-reply-to:content-transfer-encoding;
	bh=1RZQN+ygZv7NlJq+dXqFXBZGMuXGiwPHgWiYLGazvro=;
	b=dSV39ZAly314kZGc+zmh16MlZQEIzt/T9bxJ4K1frNwwK1/PYwWL2kcIWrHf3XPSak
	IXimijSuS+loAYYqhxL9/R51a7d7ApeGqXu6zoVc9TFZZ/aAGHnxaxeZct+ssTiLPwoC
	qGiJLmQi0qfp1I+0gT8LX+RoL8AWZk9MqGQE8=
Message-ID: <58B71220.6080306@cumulusnetworks.com>
Date: Wed, 01 Mar 2017 10:25:36 -0800
From: Roopa Prabhu <roopa@cumulusnetworks.com>
MIME-Version: 1.0
References: <1488379845-38625-1-git-send-email-yotamg@mellanox.com>
In-Reply-To: <1488379845-38625-1-git-send-email-yotamg@mellanox.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] bridge: Fix error path in nbp_vlan_init
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Yotam Gigi <yotamg@mellanox.com>
Cc: idosch@mellanox.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, jiri@mellanox.com, eladr@mellanox.com, davem@davemloft.net

On 3/1/17, 6:50 AM, Yotam Gigi wrote:
> Fix error path order in nbp_vlan_init, so if switchdev_port_attr_set
> call failes, the vlan_hash wouldn't be destroyed before inited.
>
> Fixes: efa5356b0d97 ("bridge: per vlan dst_metadata netlink support")
> CC: Roopa Prabhu <roopa@cumulusnetworks.com>
> Signed-off-by: Yotam Gigi <yotamg@mellanox.com>
> ---
>  
Acked-by: Roopa Prabhu <roopa@cumulusnetworks.com>

Thanks yotam.


