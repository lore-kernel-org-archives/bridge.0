Return-Path: <ser@man.szczecin.pl>
References: <571F6F45.7070000@man.szczecin.pl>
From: Seweryn Niemiec <ser@man.szczecin.pl>
Message-ID: <573070AC.70101@man.szczecin.pl>
Date: Mon, 9 May 2016 13:12:44 +0200
MIME-Version: 1.0
In-Reply-To: <571F6F45.7070000@man.szczecin.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PROBLEM] mac address learned on wrong port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi

I've found a root of the problem. It is an unexpected "feature" of Intel's X710 
network adapter.
More here: https://communities.intel.com/thread/62234
-- 
Best regards,
Seweryn Niemiec
