Return-Path: <stephen@networkplumber.org>
Date: Mon, 4 Feb 2013 08:24:09 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20130204082409.422ba135@nehalam.linuxnetplumber.net>
In-Reply-To: <1359748930-31475-1-git-send-email-vyasevic@redhat.com>
References: <1359748930-31475-1-git-send-email-vyasevic@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v9 net-next 00/12] Add basic VLAN support to
	bridges
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vlad Yasevich <vyasevic@redhat.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net

One thing I am not clear about is whether is supposed to be just
a simple filter of VLAN traffic, or a full VLAN aware bridge.

The change to make FDB entries per-VLAN seems to be the biggest tipping
point into a full VLAN bridge. I am concerned that might break existing
API's and Spanning Tree (internal and external).

