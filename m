Date: Fri, 16 Apr 2004 14:12:57 -0700
From: "David S. Miller" <davem@redhat.com>
Message-Id: <20040416141257.345e916b.davem@redhat.com>
In-Reply-To: <20040413151630.710042e3@dell_ss3.pdx.osdl.net>
References: <20040413151630.710042e3@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: [PATCH 2.6.5] (1/9) bridge - include file cleanup
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

On Tue, 13 Apr 2004 15:16:30 -0700
Stephen Hemminger <shemminger@osdl.org> wrote:

> Cleanup some of the include file's in the bridge code.
> * if_bridge.h defines net_bridge, but not needed as part of the API.
> * get rid of places that include if_bridge.h and uaccess.h but don't
>   actually do API work.

Applied.
