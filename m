Date: Thu, 10 Mar 2005 18:49:41 -0800
From: "David S. Miller" <davem@davemloft.net>
Message-Id: <20050310184941.21a033bb.davem@davemloft.net>
In-Reply-To: <20050310154429.0f879894@dxpl.pdx.osdl.net>
References: <20050310154429.0f879894@dxpl.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: [PATCH] (1/4) bridge: use jenkins hash
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

On Thu, 10 Mar 2005 15:44:29 -0800
Stephen Hemminger <shemminger@osdl.org> wrote:

> Replace the existing mac hash in the bridge code with the nice
> inline jenkins hash. This should provide better distribution across
> hash buckets and compiles to code that is similar in complexity.
> 
> Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

Applied, thanks Stephen.
