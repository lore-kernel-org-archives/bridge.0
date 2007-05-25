Date: Fri, 25 May 2007 20:49:23 +0200
From: Adam Osuchowski <adwol@zonk.pl>
Subject: Re: [Bridge] [BUG] Dropping fragmented IP packets within VLAN frames
	on bridge
Message-ID: <20070525184923.5879f05d@zonk.pl>
References: <20070525081750.5ba4a411@zonk.pl>
	<20070525085947.12841835@freepuppy>
	<20070525174925.41bd6b2e@zonk.pl> <20070525110013.1d2242e8@oldman>
	<20070525181705.5c20df89@zonk.pl> <20070525112809.68da124e@oldman>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070525112809.68da124e@oldman>
Reply-To: Adam Osuchowski <adwol@zonk.pl>
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: bridge@lists.linux-foundation.org

Stephen Hemminger wrote:
> Your original code was calling ip_fragment for all VLAN tagged frames

Right, but second version (after your suggestions) checks length of VLAN
frames and behaves better. I don't persist with the former.
