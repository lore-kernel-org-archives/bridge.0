Date: Fri, 13 Mar 2009 14:27:18 -0700 (PDT)
Message-Id: <20090313.142718.21189207.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <74b87ec3359e6e65d59cd6fb62a83fb469e6c8ae.1236702228.git.scott@canonical.com>
References: <cover.1236702228.git.scott@canonical.com>
	<74b87ec3359e6e65d59cd6fb62a83fb469e6c8ae.1236702228.git.scott@canonical.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 01/31] bridge: Auto-load bridge module when
 socket opened.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: scott@canonical.com
Cc: bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org

From: Scott James Remnant <scott@canonical.com>
Date: Mon, 2 Mar 2009 16:40:10 +0000

> The bridge module is missing the net-pf-7 alias that would cause it to
> be auto-loaded when a socket of that type is opened.  This patch adds
> the alias.
> 
> Signed-off-by: Scott James Remnant <scott@canonical.com>
> Signed-off-by: Tim Gardner <tim.gardner@canonical.com>

Bridging has no sockets, so this patch won't do anything.

Did you verify that these changes actually do something?
Or did you blindly run around peppering source files with
these annotations?
