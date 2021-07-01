Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dWMUjeCKPdLeFUp+gxh669fnhppbw46JBj0Gn+rjOw=;
 b=pYU6m9dj5CtGMCN6fVSobElnaQIxYZIlABMOEV3zgLX68+hx2Ptku0egOIhBpljcY/FsYSs7cqfqbZ7VZSs7cKy0MeZC0hpYVYVcAPkUsa/e1SYT4A9Dz9QXRgeLu6VgfGMnrjToG1Hz9OKW9FoCe246Z/+SjGIs01smMjyBqG2bNHLg+1jGcwPF9W9xubavrq7D26n8alQ6Sv4TVWoacuilzcmalME+pgou9/CPuHY2DajiHyZDVFxV9hOpWMlHk8/LDQJKYk8yp0jX5OeFzKlU54WSjm1SkYijaO5TGcUJF0P27vt3EsoQMd2IQN1mvVv1jHDgTmZzuMfUy0oVVQ==
References: <20210701122830.2652-1-w.bumiller@proxmox.com>
 <20210701122830.2652-2-w.bumiller@proxmox.com>
 <39385134-e499-2444-aa0d-48b0315e1002@nvidia.com>
 <131fc6eb-7da2-ccac-2da0-b82c19dfef84@proxmox.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <5a470258-a06b-64d0-fca0-f4eafe7e23e2@nvidia.com>
Date: Thu, 1 Jul 2021 18:33:20 +0300
In-Reply-To: <131fc6eb-7da2-ccac-2da0-b82c19dfef84@proxmox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH 1/1] net: bridge: sync fdb to new
	unicast-filtering ports
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Thomas Lamprecht <t.lamprecht@proxmox.com>, Wolfgang Bumiller <w.bumiller@proxmox.com>, netdev@vger.kernel.org
Cc: Vlad Yasevich <vyasevic@redhat.com>, Jakub Kicinski <kuba@kernel.org>, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, Roopa Prabhu <roopa@nvidia.com>

On 01/07/2021 17:51, Thomas Lamprecht wrote:
> On 01.07.21 15:49, Nikolay Aleksandrov wrote:
>> On 01/07/2021 15:28, Wolfgang Bumiller wrote:
>>> Since commit 2796d0c648c9 ("bridge: Automatically manage
>>> port promiscuous mode.")
>>> bridges with `vlan_filtering 1` and only 1 auto-port don't
>>> set IFF_PROMISC for unicast-filtering-capable ports.
>>>
>>> Normally on port changes `br_manage_promisc` is called to
>>> update the promisc flags and unicast filters if necessary,
>>> but it cannot distinguish between *new* ports and ones
>>> losing their promisc flag, and new ports end up not
>>> receiving the MAC address list.
>>>
>>> Fix this by calling `br_fdb_sync_static` in `br_add_if`
>>> after the port promisc flags are updated and the unicast
>>> filter was supposed to have been filled.
>>>
>>> Signed-off-by: Wolfgang Bumiller <w.bumiller@proxmox.com>
>>> ---
>>>  net/bridge/br_if.c | 12 ++++++++++++
>>>  1 file changed, 12 insertions(+)
>>>
>>> diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
>>> index f7d2f472ae24..183e72e7b65e 100644
>>> --- a/net/bridge/br_if.c
>>> +++ b/net/bridge/br_if.c
>>> @@ -652,6 +652,18 @@ int br_add_if(struct net_bridge *br, struct net_device *dev,
>>>  	list_add_rcu(&p->list, &br->port_list);
>>>  
>>>  	nbp_update_port_count(br);
>>> +	if (!br_promisc_port(p) && (p->dev->priv_flags & IFF_UNICAST_FLT)) {
>>> +		/* When updating the port count we also update all ports'
>>> +		 * promiscuous mode.
>>> +		 * A port leaving promiscuous mode normally gets the bridge's
>>> +		 * fdb synced to the unicast filter (if supported), however,
>>> +		 * `br_port_clear_promisc` does not distinguish between
>>> +		 * non-promiscuous ports and *new* ports, so we need to
>>> +		 * sync explicitly here.
>>> +		 */
>>> +		if (br_fdb_sync_static(br, p))
>>> +			netdev_err(dev, "failed to sync bridge addresses to this port\n");
>>> +	}
>>>  
>>>  	netdev_update_features(br->dev);
>>>  
>>>
>>
>> Hi,
> 
> Hi, commenting as was peripherally involved into this.
> 
>> The patch is wrong because br_add_if() can fail after you sync these entries and
>> then nothing will unsync them. Out of curiousity what's the use case of a bridge with a
>> single port only ? Because, as you've also noted, this will be an issue only if there is
>> a single port and sounds like a corner case, maybe there's a better way to handle it.
> 
> In practice you're right, it is not often useful, but that does not means that it
> won't happen. For example, in Proxmox VE, a hypervisor/clustering debian-based distro,
> we recommend users that they need to migrate all (QEMU) VMs to another cluster-node when
> doing a (major) upgrade as with that way they get no downtime for the VMs.
> 
> Now, if the user had a bridge with a single port this was not an issue as long as VMs
> where running the TAP device we use for them where bridge ports too.
> 
> But on reboot, with all VMs and thus ports still gone, the system comes up with that
> bridge having a single port.
> 
> That itself was seen as a problem until recently because the system set the MAC of the
> bridge to one of the bridge ports.
> 
> But with the next Debian Version (Bullseye) we're pulling in a systemd version which
> now defaults to MACAddressPolicy=persistent[0] also for virtual devices like bridges,
> so with that update done and rebooted the bridge has another MAC address, not matching
> the one of a bridge port anymore, which means the host may, depending on some other
> side effects like vlan-awareness on (as without that promisc would be enabled anyway),
> not be ping'able and other issue anymore.
> Due to some specialty handling of learning/filtering in specific drivers this is not
> reproducible on every NIC model (IIRC, it was in igb and e1000e ones but not in some
> realtek ones).
> 
> Hope that was not written to confusingly.
> 
> [0]: https://www.freedesktop.org/software/systemd/man/systemd.link.html#MACAddressPolicy=
> 

I see, thank you for the details. Just to clarify I'm not against fixing it or against this patch,
the question was out of curiousity only, as for the patch it needs to be fixed so unsync will be
handled in the error paths after the sync and also I'd suggest changing the error message to contain
what exactly couldn't be synced:
"failed to sync bridge static fdb addresses to this port"
or something in those lines. Since this fixes actual bug please also add a Fixes: tag with the
appropriate commit id where it was introduced.

>>
>> To be honest this promisc management has caused us headaches with scale setups with thousands
>> of permanent and static entries where we don't need to sync uc lists, we've actually thought
>> about flags to disable this altogether.
> 
> FWIW, when we got this reported by a beta tester a initial (not really thought out) idea
> of mine was to drop the special br_manage_promisc case to disable promisc on the bridge
> port for one single auto-port, introduced by commit 2796d0c648c940b4796f84384fbcfb0a2399db84
> in 2014, i.e., something like (still not 100% thought out):
> 
> 
This sounds very tempting, but we might break setups which depend on that behaviour,
e.g. having 1 auto port and additional non-auto ports. There were some assumptions made
about having 1 auto port back in 2014 when these changes were made[0].

Thanks,
 Nik

[0] https://bridge.linux-foundation.narkive.com/d9Qnpa69/rfc-patch-v2-net-next-0-7-non-promisc-bidge-ports-support#post10

> ----8<----
> diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
> index f7d2f472ae24..520c79c21362 100644
> --- a/net/bridge/br_if.c
> +++ b/net/bridge/br_if.c
> @@ -147,18 +147,7 @@ void br_manage_promisc(struct net_bridge *br)
>  		if (set_all) {
>  			br_port_set_promisc(p);
>  		} else {
> -			/* If the number of auto-ports is <= 1, then all other
> -			 * ports will have their output configuration
> -			 * statically specified through fdbs.  Since ingress
> -			 * on the auto-port becomes forwarding/egress to other
> -			 * ports and egress configuration is statically known,
> -			 * we can say that ingress configuration of the
> -			 * auto-port is also statically known.
> -			 * This lets us disable promiscuous mode and write
> -			 * this config to hw.
> -			 */
> -			if (br->auto_cnt == 0 ||
> -			    (br->auto_cnt == 1 && br_auto_port(p)))
> +			if (br->auto_cnt == 0)
>  				br_port_clear_promisc(p);
>  			else
>  				br_port_set_promisc(p);
> 

