Return-Path: <samuel.thibault@ens-lyon.org>
Resent-Message-ID: <20160619134704.GU9215@var.home>
Resent-To: bridge@lists.linux-foundation.org
Date: Sun, 19 Jun 2016 15:45:26 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Message-ID: <20160619134526.GA8292@var.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [Bridge] resolving MACs through /etc/ethers?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@linux-foundation.org

Hello,

I wanted to check which MACs show up in brctl showmacs, and I would
have thought that brctl would have resolved the MAC addresses thanks to
/etc/ethers, so that instead of

€ brctl showmacs br0
port no	mac addr		is local?	ageing timer
  1	00:00:12:34:56:78	no		   0.59

with 

00:00:12:34:56:78 myrouter

in /etc/ethers, I would get

€ brctl showmacs br0
port no mac addr                is local?       ageing timer
  1     myrouter                no                 0.59

and of course a -n option would revert to showing the MAC address.

What do you think of that feature?

Samuel
