Date: Tue, 29 Mar 2011 23:27:22 -0700
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20110329232722.31357223@s6510>
In-Reply-To: <1301466207-16770-1-git-send-email-dongdong.deng@windriver.com>
References: <1301466207-16770-1-git-send-email-dongdong.deng@windriver.com>
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
To: Dongdong Deng <dongdong.deng@windriver.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net

On Wed, 30 Mar 2011 14:23:27 +0800
Dongdong Deng <dongdong.deng@windriver.com> wrote:

> Return 'false' for "user has set a mac addr" case in
> br_stp_recalculate_bridge_id() function.
> 
> and this could address the following build warning:
> 
> net/bridge/br_stp_if.c: In function br_stp_recalculate_bridge_id:
> net/bridge/br_stp_if.c:216: warning: return with no value, in function
> returning non-void
> 
> Signed-off-by: Dongdong Deng <dongdong.deng@windriver.com>

Patch has already been submitted and acke'd for this.
