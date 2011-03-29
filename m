Date: Tue, 29 Mar 2011 11:10:38 -0700
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20110329111038.2928bef7@s6510>
In-Reply-To: <1301415604-3871-1-git-send-email-balajig81@gmail.com>
References: <1301415604-3871-1-git-send-email-balajig81@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH] bridge: Fix compilation warning in function
 br_stp_recalculate_bridge_id()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "G.Balaji" <balajig81@gmail.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

On Tue, 29 Mar 2011 21:50:04 +0530
"G.Balaji" <balajig81@gmail.com> wrote:

> net/bridge/br_stp_if.c: In function =E2=80=98br_stp_recalculate_bridge_id=
=E2=80=99:
> net/bridge/br_stp_if.c:216:3: warning: =E2=80=98return=E2=80=99 with no v=
alue, in function returning non-void
>=20
> Signed-off-by: G.Balaji <balajig81@gmail.com>

Acked-by: Stephen Hemminger <shemminger@vyatta.com>

(Forget to refresh quilt patch before sending).
