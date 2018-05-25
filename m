Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=YRD/zkjpHCH3dQMt0dJ/skDsYgx3o5E+N4lQ2DO1zDQ=;
	b=bHcEG/IH9Ecze4kJcPBJc0dMkS29w6C/KZXsfyo+hkwqp1jJhZ7a7D/jaN8c5bISxH
	4/lmr2DSpicbICDHEsWFB+9AJ0EW/hg0riBckl15vYsQfc6jjuC71BNMEiyWBX0RTdw4
	+4uo/cc0ZMgnbQmKLkxMVzLZcWavQHiFuxOGUL0qFIL2D7Q4EDCfgoQBWrIj72BmhyQh
	eRel5KTMb3DTRdQIb8OX9p5ZFmXxfEazbaFCp796rRoUMnTxNLccC9eFsCnC2WxBe6Ep
	8XW6UzLtIYoAiknqEDAfCwpYOgQEuf88yBJte97sTGMAGlaxmD2kKds4+fSSTEP0MKhI
	jL8Q==
References: <cover.1527173527.git.petrm@mellanox.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <9ac1bc87-7db6-1a7a-9560-b0f02bab481d@gmail.com>
Date: Thu, 24 May 2018 20:41:15 -0700
MIME-Version: 1.0
In-Reply-To: <cover.1527173527.git.petrm@mellanox.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 0/7] net: bridge: Notify about bridge
	VLANs
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Petr Machata <petrm@mellanox.com>, netdev@vger.kernel.org, devel@driverdev.osuosl.org, bridge@lists.linux-foundation.org
Cc: andrew@lunn.ch, nikolay@cumulusnetworks.com, gregkh@linuxfoundation.org, vivien.didelot@savoirfairelinux.com, idosch@mellanox.com, jiri@mellanox.com, razvan.stefanescu@nxp.com, davem@davemloft.net



On 05/24/2018 08:09 AM, Petr Machata wrote:
> In commit 946a11e7408e ("mlxsw: spectrum_span: Allow bridge for gretap
> mirror"), mlxsw got support for offloading mirror-to-gretap such that
> the underlay packet path involves a bridge. In that case, the offload is
> also influenced by PVID setting of said bridge. However, changes to VLAN
> configuration of the bridge itself do not generate switchdev
> notifications, so there's no mechanism to prod mlxsw to update the
> offload when these settings change.
> 
> In this patchset, the problem is resolved by distributing the switchdev
> notification SWITCHDEV_OBJ_ID_PORT_VLAN also for configuration changes
> on bridge VLANs. Since stacked devices distribute the notification to
> lower devices, such event eventually reaches the driver, which can
> determine whether it's a bridge or port VLAN by inspecting orig_dev.
> 
> To keep things consistent, the newly-distributed notifications observe
> the same protocol as the existing ones: dual prepare/commit, with
> -EOPNOTSUPP indicating lack of support, even though there's currently
> nothing to prepare for and nothing to support. Correspondingly, all
> switchdev drivers have been updated to return -EOPNOTSUPP for bridge
> VLAN notifications.

This is great, see the other two emails about why I like it so much:

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Tested-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks!

> 
> In patch #1, the code to send notifications for adding and deleting is
> factored out into two named functions.
> 
> In patches #2-#5, respectively for mlxsw, rocker, DSA and DPAA2 ethsw,
> the new notifications (which are not enabled yet) are ignored to
> maintain the current behavior.
> 
> In patch #6, the notification is actually enabled.
> 
> In patch #7, mlxsw is changed to update offloads of mirror-to-gre also
> for bridge-related notifications.
> 
> Petr Machata (7):
>   net: bridge: Extract boilerplate around switchdev_port_obj_*()
>   mlxsw: spectrum_switchdev: Ignore bridge VLAN events
>   rocker: rocker_main: Ignore bridge VLAN events
>   dsa: port: Ignore bridge VLAN events
>   staging: fsl-dpaa2: ethsw: Ignore bridge VLAN events
>   net: bridge: Notify about bridge VLANs
>   mlxsw: spectrum_switchdev: Schedule respin during trans prepare
> 
>  .../ethernet/mellanox/mlxsw/spectrum_switchdev.c   |  8 ++-
>  drivers/net/ethernet/rocker/rocker_main.c          |  6 +++
>  drivers/staging/fsl-dpaa2/ethsw/ethsw.c            |  6 +++
>  net/bridge/br_vlan.c                               | 58 ++++++++++++++--------
>  net/dsa/port.c                                     |  6 +++
>  5 files changed, 62 insertions(+), 22 deletions(-)
> 

-- 
Florian
