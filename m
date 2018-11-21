Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=Q9sAmFRpkPRcjTUot/o8HLRa2msLs+yCvYAOR33jA6k=;
	b=AZ59/ofFFLe2hXhlAV0QcQwiXrO6N3wDTX4Igym4bCF7QdeSvvVdgrATYvO3wpEhT1iDlMtJOT1v3o6lWEXOiT2ccEyZt6cUORhNwFJl3pJNtdaENJIhlRz68FYEK2UhHEqcCGIs/3Qu9fFPw4EeTYVbJiFLUlmikYw7qhFJaTs=
From: Ido Schimmel <idosch@mellanox.com>
Date: Wed, 21 Nov 2018 08:02:37 +0000
Message-ID: <20181121080141.16676-5-idosch@mellanox.com>
References: <20181121080141.16676-1-idosch@mellanox.com>
In-Reply-To: <20181121080141.16676-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 04/16] vxlan: Don't override user-added
 entries with ext-learned ones
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>
Cc: "ivecera@redhat.com" <ivecera@redhat.com>, Ido Schimmel <idosch@mellanox.com>, mlxsw <mlxsw@mellanox.com>, "nikolay@cumulusnetworks.com" <nikolay@cumulusnetworks.com>, "roopa@cumulusnetworks.com" <roopa@cumulusnetworks.com>, Jiri Pirko <jiri@mellanox.com>, Petr Machata <petrm@mellanox.com>, "davem@davemloft.net" <davem@davemloft.net>

From: Petr Machata <petrm@mellanox.com>

When an external learning event collides with an user-added entry, the
user-added entry shouldn't be taken over. Otherwise on an unlearn event
the entry would be completely lost, even though the user added it by
hand.

Therefore skip update of FDB flags and state for these cases. This is in
accordance with the bridge behavior.

Signed-off-by: Petr Machata <petrm@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
---
 drivers/net/vxlan.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
index 9171c1f42fe9..b50705a50686 100644
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -780,16 +780,24 @@ static int vxlan_fdb_update(struct vxlan_dev *vxlan,
 				   "lost race to create %pM\n", mac);
 			return -EEXIST;
 		}
-		if (f->state !=3D state) {
-			f->state =3D state;
-			f->updated =3D jiffies;
-			notify =3D 1;
-		}
-		if (f->flags !=3D fdb_flags) {
-			f->flags =3D fdb_flags;
-			f->updated =3D jiffies;
-			notify =3D 1;
+
+		/* Do not allow an externally learned entry to take over an
+		 * entry added by the user.
+		 */
+		if (!(fdb_flags & NTF_EXT_LEARNED) ||
+		    !(f->flags & NTF_VXLAN_ADDED_BY_USER)) {
+			if (f->state !=3D state) {
+				f->state =3D state;
+				f->updated =3D jiffies;
+				notify =3D 1;
+			}
+			if (f->flags !=3D fdb_flags) {
+				f->flags =3D fdb_flags;
+				f->updated =3D jiffies;
+				notify =3D 1;
+			}
 		}
+
 		if ((flags & NLM_F_REPLACE)) {
 			/* Only change unicasts */
 			if (!(is_multicast_ether_addr(f->eth_addr) ||
--=20
2.19.1

