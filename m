Date: Thu, 31 Mar 2011 15:31:00 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Message-Id: <20110331153100.44b02f86.akpm@linux-foundation.org>
In-Reply-To: <20110331103822.39b1a89e@nehalam>
References: <1301466207-16770-1-git-send-email-dongdong.deng@windriver.com>
	<20110331103822.39b1a89e@nehalam>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] bridge: return value for
 br_stp_recalculate_bridge_id()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Dongdong Deng <dongdong.deng@windriver.com>, davem@davemloft.net

On Thu, 31 Mar 2011 10:38:22 -0700
Stephen Hemminger <shemminger@vyatta.com> wrote:

> Reported 3 times and already fixed.

Four times!

Heaven knows why gcc treats that as a warning and not an error.  It's a
guaranteed runtime bug.

