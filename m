Date: Tue, 29 Jun 2004 16:21:19 -0700
From: "David S. Miller" <davem@redhat.com>
Message-Id: <20040629162119.41f7bed9.davem@redhat.com>
In-Reply-To: <20040629153740.11e35bb1@dell_ss3.pdx.osdl.net>
References: <s0dc91e5.046@EMAIL>
	<20040629153740.11e35bb1@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: [PATCH 2.4] Bridge STP message age
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: kishoreak@myw.ltindia.com, bridge@lists.osdl.org

On Tue, 29 Jun 2004 15:37:40 -0700
Stephen Hemminger <shemminger@osdl.org> wrote:

> This is the 2.4 version which incorporates the observations from Kishore
> about 2.6. The existing 2.4 code set the age properly, but did not increment
> correctly for HZ=1000 and could send a stale (expired) configuration.

Both 2.4.x and 2.6.x variants applied, thanks Stephen.
