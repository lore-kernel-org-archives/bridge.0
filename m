Date: Tue, 5 Jul 2011 14:28:58 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20110705142858.3b7e5941@nehalam.ftrdhcpuser.net>
In-Reply-To: <201106301033.23997.alexander.stein@systec-electronic.com>
References: <201106301033.23997.alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] possible bridge regression in "bridge: implement
 [add/del]_slave ops"?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org

I just put a fix for the detection of bridge pseudo-device being up
into the current rstp code available at:
  git://git.kernel.org/pub/scm/linux/kernel/git/shemminger/rstp.git
