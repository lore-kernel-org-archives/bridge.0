Date: Wed, 4 Aug 2004 09:58:10 -0700
From: "David S. Miller" <davem@redhat.com>
Message-Id: <20040804095810.0cbd94dd.davem@redhat.com>
In-Reply-To: <20040803130703.29a1c161@dell_ss3.pdx.osdl.net>
References: <20040803130703.29a1c161@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: [PATCH 2.6] bridge -- rmmod device while bridge is
	down fails
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

On Tue, 3 Aug 2004 13:07:03 -0700
Stephen Hemminger <shemminger@osdl.org> wrote:

> The changes to bridge notifier to handle link state changes introduced
> a bug. The case of device unregistering while bridge is down was no
> longer being handled. Add comment so maintainer doesn't forget.

Looks good, applied.
