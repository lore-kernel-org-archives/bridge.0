Return-Path: <shmulik.ladkani@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:date:from:to:cc:subject:message-id:in-reply-to
	:references:mime-version:content-type:content-transfer-encoding;
	bh=qL6c3pggP8W4fSzLruO2YoNMVGQXoS+ipHyRT4R4750=;
	b=zfdIaTx/4CgolvKSryjzXrp6SdqNYdPw8QzfZLLdt6EQ6/Wt257dWYywc42qe4OsPK
	j0HFrT1dlQdfBM45AwMbbsOZhipKt0LCqiRh28YRPKdWPspWHV5NanvlKxsUKJ+/sYVa
	YL880JGesmkykAGgohoG/IGlHSAPnAwr9utUGubXzNCFpXoGkrJfZuJ/grXE/+g3bjs6
	cfdg48UapONNS8Uc4zxKyVTyrcDHf0bK3rTKknDk5yblYK741fzNe1cT9JCZMjMAwo3r
	+65u0SSJ5ZpWpA9s/0tVquQj2rM3kyv8pMMiPVP0Pvvk9THMHsBR0zIwJhvH/opFjXZT
	ENXw==
From: Shmulik Ladkani <shmulik.ladkani@gmail.com>
Message-ID: <20130121002710.5189a959.shmulik.ladkani@gmail.com>
In-Reply-To: <1358360289-23249-4-git-send-email-vyasevic@redhat.com>
References: <1358360289-23249-1-git-send-email-vyasevic@redhat.com>
	<1358360289-23249-4-git-send-email-vyasevic@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next V6 03/14] bridge: Validate that vlan
 is permitted on ingress
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Sun, 20 Jan 2013 22:27:21 -0000
To: Vlad Yasevich <vyasevic@redhat.com>
Cc: netdev@vger.kernel.org, shemminger@vyatta.com, bridge@lists.linux-foundation.org, davem@davemloft.net, mst@redhat.com

Hi Vlad,

On Wed, 16 Jan 2013 13:17:58 -0500 Vlad Yasevich <vyasevic@redhat.com> wrote:
> @@ -45,6 +45,9 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
>  	brstats->tx_bytes += skb->len;
>  	u64_stats_update_end(&brstats->syncp);
>  
> +	if (!br_allowed_ingress(&br->vlan_info, skb))
> +		goto out;
> +

Shouldn't you consume the 'skb' in case "not allowed"? the 'out' label
doesn't take care of that.

> +bool br_allowed_ingress(struct net_port_vlans *v, struct sk_buff *skb)
> +{
> +	struct net_port_vlan *pve;
> +	u16 vid;
> +
> +	/* If there are no vlan in the permitted list, all packets are
> +	 * permitted.
> +	 */
> +	if (list_empty(&v->vlan_list))
> +		return true;

Rethinking this, after discussed at [1].
The above means the port having no vlans is actually a member of every
possible vlan.
IMO it might not be what users expect, and may complicate things.

Maybe we should adapt a simpler approach:
If the bridge is a vlan enabled bridge, and the port is not a member of
the given vid, drop.
If the bridge is "vlan disabled", then all packets are permitted.

Regards,
Shmulik

[1]
http://marc.info/?l=linux-netdev&m=135602065425514&w=2
