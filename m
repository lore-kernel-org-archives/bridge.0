Date: Tue, 13 Jan 2004 16:19:03 -0800
From: "David S. Miller" <davem@redhat.com>
Message-Id: <20040113161903.5eaf893a.davem@redhat.com>
In-Reply-To: <20040112134645.461f125e.shemminger@osdl.org>
References: <20040112134645.461f125e.shemminger@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: [PATCH] bridge use read_lock when scanning device list
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: netdev@oss.sgi.com, bridge@osdl.org

On Mon, 12 Jan 2004 13:46:45 -0800
Stephen Hemminger <shemminger@osdl.org> wrote:

> On 2.6.1, bridge is using rtnl_shlock which is equivalent to rtnl_lock when
> all it really needs to do is read_lock(&dev_base_lock).

Applied, thanks Stephen.
