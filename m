Return-Path: <stephen@networkplumber.org>
Date: Thu, 2 May 2013 10:23:31 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20130502102331.43728912@nehalam.linuxnetplumber.net>
In-Reply-To: <1366404770-28523-1-git-send-email-vyasevic@redhat.com>
References: <1366404770-28523-1-git-send-email-vyasevic@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v2 net-next 0/6] Allow bridge to function in
 non-promisc mode
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vlad Yasevich <vyasevic@redhat.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, mst@redhat.com

Doing research on another problem, I noticed that this would
break user mode spanning tree (RSTP) code.

The daemon assumes that bridge is promicious mode and therefore
will receive all link-level multicast packets.
