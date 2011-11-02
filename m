Return-Path: <drobbins@funtoo.org>
MIME-Version: 1.0
Date: Wed, 2 Nov 2011 11:07:31 -0600
Message-ID: <CAPDOV4-tbh0TOQMtX+s5xtiwbycn-=nL_2R8w58FHYbUTEBwxw@mail.gmail.com>
From: Daniel Robbins <drobbins@funtoo.org>
Content-Type: text/plain; charset=UTF-8
Subject: [Bridge] RHEL 6 stack corruption bug in bridge code identified
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi Stephen,

The OpenVZ developers have identified a linux bridging stack
corruption bug in the RHEL 6 kernel:

http://bugzilla.openvz.org/show_bug.cgi?id=2016#c15

Can you confirm that this appears to be a stack corruption bug? Has it
already been fixed? If so, which kernel has it fixed? If not, can you
get a fix into an upcoming vanilla kernel? Thanks :)

-Daniel
