Date: Wed, 19 Jan 2005 10:31:28 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Bridge port states
Message-ID: <20050119103128.08310478@dxpl.pdx.osdl.net>
In-Reply-To: <41EE9D8E.20208@student.ethz.ch>
References: <41EE9D8E.20208@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: stuedip@student.ethz.ch
Cc: bridge@lists.osdl.org

On Wed, 19 Jan 2005 18:49:02 +0100
Patrick Stuedi <stuedip@student.ethz.ch> wrote:

> Hi all,
> 
> Can anyone explain me why we need all this per port state information. A 
> bridge port seems to be either in BR_STATE_LISTENING, BR_STATE_LEARNING 
> or BR_STATE_FORWARDING. I don't get it, thought the bridge is learning 
> from MAC addresses of the received packets, therefore while listening. 
> Why a bridge port distinquishes these states?
> 
> Thanx,
> Patrick
> 

For full detail get the IEEE spec for bridging 802.1G

http://standards.ieee.org/getieee802/802.1.html

Port states are described in lots of detail in 7.4

-- 
Stephen Hemminger	<shemminger@osdl.org>
