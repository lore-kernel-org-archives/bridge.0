Date: Tue, 22 Jun 2004 17:12:50 -0700
From: "David S. Miller" <davem@redhat.com>
Message-Id: <20040622171250.59255fb3.davem@redhat.com>
In-Reply-To: <20040622163023.29a1862a@dell_ss3.pdx.osdl.net>
References: <20040622163023.29a1862a@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: [PATCH] turn off debug error message in bridge ioctl
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@osdl.org

On Tue, 22 Jun 2004 16:30:23 -0700
Stephen Hemminger <shemminger@osdl.org> wrote:

> Trivial patch to turn off a debug message.  It seems some SNMP daemons just
> periodically trying to look at MII state.
> 
> Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

Applied to 2.6.x, is a 2.4.x variant coming?
