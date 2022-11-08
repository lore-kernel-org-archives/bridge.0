Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6801F4025D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 614A9401A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CQJVvugu8oLvsWyJLc1Y3oVePQ9NOwghfaFJZvViXwA=;
 b=B/hN92IL+8Hab/e0WxYLv1wpgyxOtmrQRt5kHiaCdrUnzIcpjcqYotzXQU0Q8oBofu
 +5AzPAY317S1p3806QcDHJlh4e8PqS/a7p2lohbxNyYTFgJ+FspcnFycE3ng/Pdb9JdY
 mc7W3VGG3m0Jx1aPSedDDJiBv7Ce6Af4MR9yKG/HNu5qq5tZ8WpG+Exxpd7l3Pg/tJ0W
 hgnaLc3ayzfSJZObw2fk1TcWv03DbZUMFDJjdL1FEUU+6NSq9n4+9NivRqMehYnCNACz
 ijYqmtQ1Niet+GBQ3P5ahmoWynK6xaXehrK9jKB8uhrx0Y5gtmmlsFfCeYkNmNaVOc/3
 3s5g==
Date: Tue, 8 Nov 2022 16:21:44 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20221108142144.g7wa22k4udaqofmw@skbuf>
References: <cover.1667902754.git.petrm@nvidia.com>
 <cover.1667902754.git.petrm@nvidia.com>
 <68167a3ebca74bb7cd45da0ff7c1268a70c33a96.1667902754.git.petrm@nvidia.com>
 <68167a3ebca74bb7cd45da0ff7c1268a70c33a96.1667902754.git.petrm@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68167a3ebca74bb7cd45da0ff7c1268a70c33a96.1667902754.git.petrm@nvidia.com>
 <68167a3ebca74bb7cd45da0ff7c1268a70c33a96.1667902754.git.petrm@nvidia.com>
Subject: Re: [Bridge] [PATCH net-next 02/15] bridge: switchdev: Allow device
 drivers to install locked FDB entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Petr Machata <petrm@nvidia.com>
Cc: Ivan Vecera <ivecera@redhat.com>, bridge@lists.linux-foundation.org, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, Jiri Pirko <jiri@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, "Hans J . Schultz" <netdev@kapio-technology.com>, Eric Dumazet <edumazet@google.com>, mlxsw@nvidia.com, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

On Tue, Nov 08, 2022 at 11:47:08AM +0100, Petr Machata wrote:
> From: Hans J. Schultz <netdev@kapio-technology.com>
> 
> When the bridge is offloaded to hardware, FDB entries are learned and
> aged-out by the hardware. Some device drivers synchronize the hardware
> and software FDBs by generating switchdev events towards the bridge.
> 
> When a port is locked, the hardware must not learn autonomously, as
> otherwise any host will blindly gain authorization. Instead, the
> hardware should generate events regarding hosts that are trying to gain
> authorization and their MAC addresses should be notified by the device
> driver as locked FDB entries towards the bridge driver.
> 
> Allow device drivers to notify the bridge driver about such entries by
> extending the 'switchdev_notifier_fdb_info' structure with the 'locked'
> bit. The bit can only be set by device drivers and not by the bridge
> driver.
> 
> Prevent a locked entry from being installed if MAB is not enabled on the
> bridge port.
> 
> If an entry already exists in the bridge driver, reject the locked entry
> if the current entry does not have the "locked" flag set or if it points
> to a different port. The same semantics are implemented in the software
> data path.
> 
> Signed-off-by: Hans J. Schultz <netdev@kapio-technology.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
> 
> Notes:
>     v1:
>     * Adjust commit message.
>     * Add a check in br_switchdev_fdb_notify().
>     * Use 'false' instead of '0' in br_switchdev_fdb_populate().

Thanks for making the changes.

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

(imagine this was my NXP email address, I'm not subscribed to netdev @work)
