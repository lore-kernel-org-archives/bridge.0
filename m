Return-Path: <davem@davemloft.net>
Date: Wed, 24 Jun 2020 14:37:08 -0700 (PDT)
Message-Id: <20200624.143708.1919481157205194723.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200623204718.1057508-1-nikolay@cumulusnetworks.com>
References: <20200623204718.1057508-1-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 0/4] net: bridge: fdb activity tracking
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, anuradhak@cumulusnetworks.com

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Tue, 23 Jun 2020 23:47:14 +0300

> This set adds extensions needed for EVPN multi-homing proper and
> efficient mac sync. User-space (e.g. FRR) needs to be able to track
> non-dynamic entry activity on per-fdb basis depending if a tracked fdb is
> currently peer active or locally active and needs to be able to add new
> peer active fdb (static + track + inactive) without refreshing it to get
> real activity tracking. Patch 02 adds a new NDA attribute - NDA_FDB_EXT_ATTRS
> to avoid future pollution of NDA attributes by bridge or vxlan. New
> bridge/vxlan specific fdb attributes are embedded in NDA_FDB_EXT_ATTRS,
> which is used in patch 03 to pass the new NFEA_ACTIVITY_NOTIFY attribute
> which controls if an fdb should be tracked and also reflects its current
> state when dumping. It is treated as a bitfield, current valid bits are:
>  1 - mark an entry for activity tracking
>  2 - mark an entry as inactive to avoid multiple notifications and
>      reflect state properly
> 
> Patch 04 adds the ability to avoid refreshing an entry when changing it
> via the NFEA_DONT_REFRESH flag. That allows user-space to mark a static
> entry for tracking and keep its real activity unchanged.
> The set has been extensively tested with FRR and those changes will
> be upstreamed if/after it gets accepted.

Series applied, thanks.
