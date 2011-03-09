Date: Wed, 9 Mar 2011 10:44:49 -0600
From: Adam Majer <adamm@zombino.com>
Message-ID: <20110309164448.GA2364@mira.lan.galacticasoftware.com>
References: <20110306051833.GA3098@mira.lan.galacticasoftware.com>
	<20110309150949.GE16951@cr0.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20110309150949.GE16951@cr0.redhat.com>
Subject: Re: [Bridge] [PATCH 1/2] Issue NETDEV_CHANGE notification when
 bridge changes state
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?iso-8859-1?Q?Am=E9rico?= Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org

On Wed, Mar 09, 2011 at 11:09:49PM +0800, Am=E9rico Wang wrote:
> On Sat, Mar 05, 2011 at 11:18:33PM -0600, Adam Majer wrote:
> >
> >IPv6 address autoconfiguration relies on an UP interface to processes
> >traffic normally. A bridge that is UP enters LEARNING state and this
> >state "eats" any Router Advertising packets sent to the
> >bridge. Issuing a NETDEV_CHANGE notification on the bridge interface
> >when it changes state allows autoconfiguration code to retry
> >querying router information.
> >
> ...
>=20
> >+static void br_port_change_notifier_handler(struct work_struct *work)
> >+{
> >+	struct net_bridge *br =3D container_of(work,
> >+					     struct net_bridge,
> >+					     change_notification_worker);
> >+
> >+	rtnl_lock();
> >+	netdev_state_change(br->dev);
> >+	rtnl_unlock();
> >+}
> >+
>=20
> Do you really want user-space to get this notification too?
> Why do you put it into a workqueue? Maybe it has to be called in
> process-context?

Stephen Hemminger's patch (posted as a reply in this thread but only
on the netdev mailing list) is much better as it only brings the link
up on the bridge interface when the bridge enters forwarding mode.

Effectively it does similar thing via NETDEV_CHANGE but requires no
other hacks in other code. It should make userland much happier too.


As for my patch, I've put that in the workqueue because the
notification cannot be called in interrupt context. Is there a better
way of calling code that can sleep from interrupt context?

- Adam

--=20
Adam Majer
adamm@zombino.com
