Return-Path: <dan.carpenter@oracle.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=date : from : to : cc
	: subject : message-id : references : mime-version : content-type :
	in-reply-to; s=corp-2017-10-26;
	bh=VOwzlC9mRQDY98qjCjyP+E4xLgHxW5nfuL4rrmHNR7w=;
	b=f+sEKTjZO/1p01nUdTnxF276Zf9aEmzoqfwD8gwOpkRYDjaZ/STCXG0tiKdjPMaQJ2uX
	RiHyrfzZGyi/J2zwoWcydgpd7RQ1kKxW6gdPnAyeqyqbrGp1A8Fh5QdgiH5EQihGfhHK
	uaW+6QxoM69T3W3S0ehvPuqhy81tOlvIhxkTQBlwgKdkUkLXzJGFHThcmX8vUeXvAYrg
	Fu2EDv7Iekt3OJj52BsaxG9SwdUc5wlEyo88D5quw7MuhDuewMwpOnKCIegqhSJDvyxA
	bce4zigXGcGmMG3VOrmKONerX27LSKiL8Tn1n3RTWGpcqqIdHELifppz1VKRIVxY1zn8
	Bg== 
Date: Tue, 29 May 2018 13:46:09 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Message-ID: <20180529104609.jqbql6ts2rbb7k3l@mwanda>
References: <cover.1527519997.git.petrm@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1527519997.git.petrm@mellanox.com>
Subject: Re: [Bridge] [PATCH net-next v3 0/7] net: bridge: Notify about
	bridge VLANs
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Petr Machata <petrm@mellanox.com>
Cc: devel@driverdev.osuosl.org, andrew@lunn.ch, f.fainelli@gmail.com, vivien.didelot@savoirfairelinux.com, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, idosch@mellanox.com, jiri@mellanox.com, razvan.stefanescu@nxp.com, gregkh@linuxfoundation.org, davem@davemloft.net

On Mon, May 28, 2018 at 05:10:22PM +0200, Petr Machata wrote:
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
> 
> In patch #1, the code to send notifications for adding and deleting is
> factored out into two named functions.
> 
> In patches #2-#5, respectively for mlxsw, rocker, DSA and DPAA2 ethsw,
> the new notifications (which are not enabled yet) are ignored to
> maintain the current behavior.
> 

It occured to me that I should read the cover letter and here are the
answers I was looking for.  But the cover letter isn't saved after the
commits are merged.  This should really be in the commit messages itself
so that we can look it up in the git history.

> In patch #6, the notification is actually enabled.
> 
> In patch #7, mlxsw is changed to update offloads of mirror-to-gre also
> for bridge-related notifications.

regards,
dan carpenter

