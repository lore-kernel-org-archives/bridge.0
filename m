Return-Path: <idosch@mellanox.com>
Date: Mon, 12 Oct 2015 20:51:56 +0300
From: Ido Schimmel <idosch@mellanox.com>
Message-ID: <20151012175156.GA16784@colbert.mtl.com>
References: <1444650069-32572-1-git-send-email-razor@blackwall.org>
	<1444650069-32572-5-git-send-email-razor@blackwall.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1444650069-32572-5-git-send-email-razor@blackwall.org>
Subject: Re: [Bridge] [PATCH net-next 4/4] bridge: vlan: combine
 (br|nbp)_vlan_flush into one
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>, sfeldma@gmail.com, vivien.didelot@savoirfairelinux.com
Cc: bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, roopa@cumulusnetworks.com, shm@cumulusnetworks.com, davem@davemloft.net

Mon, Oct 12, 2015 at 02:41:09PM IDT, razor@blackwall.org wrote:
>From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
>
>As Ido Schimmel pointed out the vlan_vid_del() loop in nbp_vlan_flush is
>unnecessary (and is actually a remnant of the old vlan code) so we can
>remove it and combine both br/nbp vlan_flush functions into one.
Just a small note to Scott and Vivien:

One of the side effects of Nik's recent patchsets is that when VLANs are
flushed on a port the deletion is propagated to the driver via
switchdev ops, as __vlan_vid_del is called.

Therefore there is no need to do internal bookkeeping and remove VLANs
yourself when port is removed from bridge.
>
>Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
